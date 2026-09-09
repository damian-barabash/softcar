import type { APIRoute } from 'astro';

// Znacznik wydania — edytor odpytuje ten plik po kliknieciu „Opublikuj”,
// zeby wiedziec, kiedy nowa wersja strony faktycznie weszla na serwer.
export const GET: APIRoute = async () =>
  new Response(JSON.stringify({ built: new Date().toISOString() }), {
    headers: { 'Content-Type': 'application/json', 'Cache-Control': 'no-store, max-age=0' },
  });
