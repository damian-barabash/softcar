// Formularz kontaktowy: walidacja -> zapis do tabeli leads -> e-mail przez Resend.
// Sekrety (RESEND_API_KEY, CONTACT_TO, CONTACT_FROM) trzymamy w sekretach projektu Supabase,
// nigdy w repozytorium.
const ALLOWED_ORIGINS = [
  'https://softcar.pl',
  'https://www.softcar.pl',
  'http://localhost:4321',
  'http://localhost:4322',
];

function cors(origin: string | null) {
  const allow = origin && ALLOWED_ORIGINS.includes(origin) ? origin : ALLOWED_ORIGINS[0];
  return {
    'Access-Control-Allow-Origin': allow,
    'Access-Control-Allow-Headers': 'content-type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Vary': 'Origin',
  };
}

const str = (v: unknown, max: number) => (typeof v === 'string' ? v.trim().slice(0, max) : '');

async function sha256(text: string) {
  const buf = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(text));
  return [...new Uint8Array(buf)].map((b) => b.toString(16).padStart(2, '0')).join('');
}

const esc = (s: string) =>
  s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

Deno.serve(async (req) => {
  const origin = req.headers.get('origin');
  const headers = { ...cors(origin), 'Content-Type': 'application/json' };

  if (req.method === 'OPTIONS') return new Response(null, { headers: cors(origin) });
  if (req.method !== 'POST') return new Response(JSON.stringify({ error: 'method' }), { status: 405, headers });

  let payload: Record<string, unknown>;
  try {
    payload = await req.json();
  } catch {
    return new Response(JSON.stringify({ error: 'json' }), { status: 400, headers });
  }

  // pulapka na boty — pole ukryte w formularzu musi zostac puste
  if (str(payload.company_www, 200)) {
    return new Response(JSON.stringify({ ok: true }), { headers });
  }

  const name = str(payload.name, 200);
  const email = str(payload.email, 320);
  const phone = str(payload.phone, 60);
  const topic = str(payload.topic, 300);
  const message = str(payload.message, 5000);
  const agree = payload.agree === 'tak' || payload.agree === true || payload.agree === 'on';

  const errors: string[] = [];
  if (name.length < 2) errors.push('name');
  if (!/^[^@\s]+@[^@\s.]+\.[^@\s]{2,}$/.test(email)) errors.push('email');
  if (topic.length < 2) errors.push('topic');
  if (message.length < 5) errors.push('message');
  if (!agree) errors.push('agree');
  if (errors.length) {
    return new Response(JSON.stringify({ error: 'validation', fields: errors }), { status: 422, headers });
  }

  const SB = Deno.env.get('SUPABASE_URL')!;
  const KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
  const db = (path: string, init: RequestInit = {}) =>
    fetch(`${SB}/rest/v1/${path}`, {
      ...init,
      headers: { apikey: KEY, Authorization: `Bearer ${KEY}`, 'Content-Type': 'application/json', ...(init.headers ?? {}) },
    });

  const ip =
    req.headers.get('cf-connecting-ip') ??
    (req.headers.get('x-forwarded-for') ?? '').split(',')[0].trim() ??
    '';
  const ipHash = ip ? await sha256(ip + (Deno.env.get('IP_SALT') ?? 'softcar')) : null;

  // proste ograniczenie tempa: max 5 zgloszen z jednego adresu w ciagu 10 minut
  if (ipHash) {
    const since = new Date(Date.now() - 10 * 60 * 1000).toISOString();
    const r = await db(`leads?select=id&ip_hash=eq.${ipHash}&created_at=gte.${since}`, {
      method: 'HEAD',
      headers: { Prefer: 'count=exact', Range: '0-0' },
    });
    const count = Number((r.headers.get('content-range') ?? '/0').split('/')[1] || 0);
    if (count >= 5) {
      return new Response(JSON.stringify({ error: 'rate_limit' }), { status: 429, headers });
    }
  }

  const ins = await db('leads?select=id', {
    method: 'POST',
    headers: { Prefer: 'return=representation' },
    body: JSON.stringify({
      name, email, phone, topic, message,
      source: 'kontakt',
      ip_hash: ipHash,
      user_agent: str(req.headers.get('user-agent'), 500),
    }),
  });
  if (!ins.ok) {
    console.error('insert leads:', ins.status, await ins.text());
    return new Response(JSON.stringify({ error: 'db' }), { status: 500, headers });
  }
  const lead = (await ins.json())[0];

  const to = Deno.env.get('CONTACT_TO') ?? 'office.softcarservice@gmail.com';
  const from = Deno.env.get('CONTACT_FROM') ?? 'Formularz softcar.pl <formularz@softcar.pl>';
  const key = Deno.env.get('RESEND_API_KEY');

  if (key) {
    const html = `
      <h2>Nowa wiadomość ze strony softcar.pl</h2>
      <p><strong>Imię i nazwisko:</strong> ${esc(name)}</p>
      <p><strong>E-mail:</strong> <a href="mailto:${esc(email)}">${esc(email)}</a></p>
      <p><strong>Telefon:</strong> ${esc(phone) || '—'}</p>
      <p><strong>Temat:</strong> ${esc(topic)}</p>
      <p><strong>Wiadomość:</strong></p>
      <p>${esc(message).replace(/\n/g, '<br>')}</p>
      <hr>
      <p style="color:#777;font-size:12px">Zgłoszenie #${lead.id} · zapisane w panelu /admin</p>`;
    try {
      const r = await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: { Authorization: `Bearer ${key}`, 'Content-Type': 'application/json' },
        body: JSON.stringify({ from, to: [to], reply_to: email, subject: `Formularz softcar.pl: ${topic}`, html }),
      });
      if (!r.ok) console.error('resend:', r.status, await r.text());
    } catch (e) {
      console.error('resend fetch:', String(e));
    }
  }

  return new Response(JSON.stringify({ ok: true, id: lead.id }), { headers });
});
