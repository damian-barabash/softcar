// Kontrola wyniku budowania: czy powstaly wszystkie strony, czy nie ma pustych plikow
// i czy do katalogu dist nie trafil zaden sekret.
import fs from 'node:fs';
import path from 'node:path';

const DIST = 'dist';
const REQUIRED = [
  'index.html', 'o-nas/index.html', 'oferta/index.html', 'cennik/index.html',
  'kontakt/index.html', 'polityka-prywatnosci/index.html', 'polityka-cookies/index.html',
  'obowiazek-informacyjny/index.html', 'admin/index.html',
  'oferta/mechanika-oraz-diagnostyka-samochodowa/index.html',
  'oferta/auto-zastepcze/index.html',
];

const problems = [];

for (const rel of REQUIRED) {
  const p = path.join(DIST, rel);
  if (!fs.existsSync(p)) problems.push(`brak pliku: ${rel}`);
  else if (fs.statSync(p).size < 1000) problems.push(`podejrzanie mały plik: ${rel}`);
}

// zadnych sekretow w wyniku budowania
const FORBIDDEN = [/service_role/i, /\bre_[A-Za-z0-9_]{16,}/, /\bsbp_[a-f0-9]{40}/, /SUPABASE_SERVICE_ROLE/];
const walk = (dir) => fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => {
  const p = path.join(dir, e.name);
  return e.isDirectory() ? walk(p) : [p];
});
for (const f of walk(DIST)) {
  if (!/\.(html|js|css|json|txt|xml)$/i.test(f)) continue;
  const txt = fs.readFileSync(f, 'utf8');
  for (const re of FORBIDDEN) {
    if (re.test(txt)) problems.push(`możliwy sekret w ${f} (wzorzec ${re})`);
  }
}

// wszystkie odwolania do zasobow lokalnych musza istniec
const missing = new Set();
for (const f of walk(DIST).filter((x) => x.endsWith('.html'))) {
  const html = fs.readFileSync(f, 'utf8');
  for (const m of html.matchAll(/(?:src|href)="(\/[^"?#]+\.(?:webp|jpg|jpeg|png|svg|ico|css|js|woff2))"/g)) {
    const p = path.join(DIST, m[1]);
    if (!fs.existsSync(p)) missing.add(m[1]);
  }
}
for (const m of missing) problems.push(`brakujący zasób: ${m}`);

if (problems.length) {
  console.error('Kontrola nie przeszła:');
  problems.forEach((p) => console.error(' -', p));
  process.exit(1);
}
console.log(`Kontrola OK — ${walk(DIST).length} plików, wszystkie wymagane strony obecne.`);
