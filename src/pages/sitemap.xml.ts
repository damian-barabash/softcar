import type { APIRoute } from 'astro';
import { getContent } from '../lib/content';

export const GET: APIRoute = async ({ site }) => {
  const c = await getContent();
  const base = (site ?? new URL('https://softcar.pl')).origin;
  const urls = [
    { loc: '/', pri: '1.0' },
    ...c.pages
      .filter((p) => p.kind !== 'legal')
      .map((p) => ({ loc: `/${p.kind === 'service' ? 'oferta/' : ''}${p.slug}/`, pri: '0.8' })),
    ...c.pages
      .filter((p) => p.kind === 'legal')
      .map((p) => ({ loc: `/${p.slug}/`, pri: '0.3' })),
  ];
  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map((u) => `  <url><loc>${base}${u.loc}</loc><priority>${u.pri}</priority></url>`).join('\n')}
</urlset>`;
  return new Response(body, { headers: { 'Content-Type': 'application/xml; charset=utf-8' } });
};
