# SOFTCAR — notatki dla asystenta

Astro (SSG) + Supabase (CMS/CRM) + GitHub Pages. Pełny opis w `README.md`.

## Zasady

- **Nie commituję i nie pushuję** — robi to użytkownik. Ja zostawiam zmiany w drzewie roboczym.
- **Repozytorium jest publiczne.** Do repo nie trafia: klucz `service_role`, token Resend, token
  GitHuba, hasła. Wyłącznie sekrety projektu Supabase. `scripts/qc.mjs` to weryfikuje.
- Klucze `PUBLIC_SUPABASE_URL` i klucz *publishable* w `src/lib/config.ts` są jawne z założenia.

## Wygląd = 1:1 ze starą stroną

Style w `src/styles/legacy*.css` pochodzą ze starego serwisu i są **generowane** przez
`scripts/build-legacy-css.py` — nie edytuj ich ręcznie. Własne uzupełnienia idą do
`src/styles/site.css`.

Klasy `.blockNNN` niosą style ze starego szablonu, dlatego numer bloku jest trzymany w bazie
(`offer_tiles.css_block`, `info_boxes.css_block`, `counters.css_block`, `slides.css_slide`).
Nowe pozycje dodane w panelu dziedziczą sensowną wartość domyślną.

`public/js/site.js` odtwarza zachowania, które w starym serwisie robił jQuery: slider (zgodny
z DOM-em slicka), szuflada menu na telefonach (`dn-nav`), równanie wysokości kolumn w wierszu,
galeria kaskadowa, pasek przewijany, zawijanie tabel w `.table-responsive`, klasy
`border-radius-sm btn-shadow` na przyciskach.

## Weryfikacja zmian

Po zmianach w warstwie wizualnej porównaj wysokości stron ze starym serwisem
(Playwright, widoki 1440 i 390 px) — rozjazd powyżej ~50 px oznacza, że coś się rozsypało.
