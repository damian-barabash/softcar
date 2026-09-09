// Uruchamia przebudowe strony w GitHub Actions (repository_dispatch).
// Token GitHuba zyje wylacznie w sekretach projektu Supabase — nigdy w repozytorium ani w przegladarce.
const ALLOWED_ORIGINS = ['https://softcar.pl', 'https://www.softcar.pl', 'http://localhost:4321'];

function cors(origin: string | null) {
  const allow = origin && ALLOWED_ORIGINS.includes(origin) ? origin : ALLOWED_ORIGINS[0];
  return {
    'Access-Control-Allow-Origin': allow,
    'Access-Control-Allow-Headers': 'content-type, authorization',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    Vary: 'Origin',
  };
}

Deno.serve(async (req) => {
  const origin = req.headers.get('origin');
  const headers = { ...cors(origin), 'Content-Type': 'application/json' };
  if (req.method === 'OPTIONS') return new Response(null, { headers: cors(origin) });
  if (req.method !== 'POST') return new Response(JSON.stringify({ error: 'method' }), { status: 405, headers });

  const auth = req.headers.get('authorization') ?? '';
  const token = auth.replace(/^Bearer\s+/i, '');
  if (!token) return new Response(JSON.stringify({ error: 'unauthorized' }), { status: 401, headers });

  const SB = Deno.env.get('SUPABASE_URL')!;
  const ANON = Deno.env.get('SUPABASE_ANON_KEY')!;
  const SR = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

  // kim jest osoba wywolujaca
  const who = await fetch(`${SB}/auth/v1/user`, {
    headers: { apikey: ANON, Authorization: `Bearer ${token}` },
  });
  if (!who.ok) return new Response(JSON.stringify({ error: 'unauthorized' }), { status: 401, headers });
  const user = await who.json();

  // czy ma dostep do panelu
  const adm = await fetch(`${SB}/rest/v1/admin_users?select=id&id=eq.${user.id}`, {
    headers: { apikey: SR, Authorization: `Bearer ${SR}` },
  });
  const rows = adm.ok ? await adm.json() : [];
  if (!rows.length) return new Response(JSON.stringify({ error: 'forbidden' }), { status: 403, headers });

  const repo = Deno.env.get('GITHUB_REPO');       // np. "uzytkownik/softcar"
  const ghToken = Deno.env.get('GITHUB_TOKEN');
  if (!repo || !ghToken) {
    return new Response(JSON.stringify({ error: 'not_configured' }), { status: 501, headers });
  }

  const gh = await fetch(`https://api.github.com/repos/${repo}/dispatches`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${ghToken}`,
      Accept: 'application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28',
      'Content-Type': 'application/json',
      'User-Agent': 'softcar-publish',
    },
    body: JSON.stringify({ event_type: 'content-publish', client_payload: { by: user.email } }),
  });

  if (!gh.ok) {
    console.error('github dispatch', gh.status, await gh.text());
    return new Response(JSON.stringify({ error: 'github', status: gh.status }), { status: 502, headers });
  }

  await fetch(`${SB}/rest/v1/audit_log`, {
    method: 'POST',
    headers: { apikey: SR, Authorization: `Bearer ${SR}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ actor: user.email, action: 'publish', entity: 'site' }),
  });

  return new Response(JSON.stringify({ ok: true }), { headers });
});
