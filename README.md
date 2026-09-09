# Soft Car Service — softcar.pl

Strona serwisu samochodowego Soft Car Service (Czechowice-Dziedzice), przeniesiona ze starej
Joomli poprzedniego wykonawcy na własny stos: **statyczny front (Astro) na GitHub Pages + Supabase
jako CMS, baza zgłoszeń i backend formularza**.

Wygląd jest odwzorowany 1:1 względem `softcarservice.pl` (stan z 09.2026), z jedną świadomą zmianą:
w stopce nie ma już odnośnika do poprzedniej agencji.

---

## Jak to działa

```
                    ┌──────────────────────────┐
   klient / redaktor│  /admin  (panel w React) │
                    └───────────┬──────────────┘
                                │ zapis treści (Supabase Auth + RLS)
                                ▼
   ┌────────────────────────────────────────────────────┐
   │  Supabase  (projekt „softcar backend”)             │
   │   • Postgres: treść stron, menu, galeria, zgłoszenia│
   │   • Storage:  pliki wgrywane z panelu               │
   │   • Edge Functions: contact (formularz), publish     │
   └───────────┬─────────────────────────────┬──────────┘
               │ odczyt przy budowaniu       │ repository_dispatch
               ▼                             ▼
   ┌────────────────────┐        ┌────────────────────────┐
   │  Astro build       │◄───────│  GitHub Actions        │
   │  → katalog dist/   │        │  .github/workflows     │
   └─────────┬──────────┘        └────────────────────────┘
             ▼
      GitHub Pages  →  https://softcar.pl
```

Treść jest wczytywana **w trakcie budowania**, więc gotowa strona to czysty HTML — bez zapytań do
bazy u odwiedzającego. Dlatego po edycji w panelu trzeba kliknąć **„Opublikuj zmiany”**: panel
wywołuje funkcję `publish`, ta wysyła zdarzenie do GitHub Actions, a Actions przebudowuje i wgrywa
stronę (ok. 1 minuty).

---

## Uruchomienie lokalne

```bash
npm install
npm run dev          # http://localhost:4321  (panel: /admin)
npm run build        # katalog dist/
node scripts/qc.mjs  # kontrola wyniku budowania
```

Klucze Supabase (adres projektu + klucz *publishable*) są wpisane w `src/lib/config.ts`.
To klucze z założenia jawne — dostęp ogranicza RLS w bazie. **Klucz `service_role`, token Resend
i token GitHuba nie mogą znaleźć się w repozytorium** — mieszkają w sekretach projektu Supabase.
Skrypt `scripts/qc.mjs` sprawdza to przy każdym budowaniu i przerywa wdrożenie, jeśli coś takiego
trafi do `dist/`.

---

## Wysyłka zmian i wdrożenie

Repozytorium jest publiczne, dlatego pilnujemy, żeby nic wrażliwego do niego nie trafiło
(`.gitignore` + kontrola w `qc.mjs`).

**Ty pushujesz, wdrożenie dzieje się samo:**

```bash
git add -A
git commit -m "opis zmiany"
git push origin main
```

Push do gałęzi `main` uruchamia `.github/workflows/deploy.yml`: instalacja → budowanie →
kontrola jakości → publikacja na GitHub Pages. Ten sam workflow startuje, gdy klient kliknie
„Opublikuj zmiany” w panelu (`repository_dispatch: content-publish`) oraz ręcznie z zakładki
Actions (`workflow_dispatch`).

### Konfiguracja po stronie GitHuba (jednorazowo)

1. Repozytorium już istnieje: **`damian-barabash/softcar`** (publiczne) — wystarczy wypchnąć ten katalog.
2. *Settings → Pages → Build and deployment → Source: **GitHub Actions***.
3. *Settings → Pages → Custom domain:* `softcar.pl`, zaznacz **Enforce HTTPS**
   (plik `public/CNAME` już zawiera tę domenę).
4. Wygeneruj token do publikowania z panelu: *Settings → Developer settings →
   Personal access tokens → Fine-grained*, dostęp tylko do tego repozytorium,
   uprawnienie **Contents: Read and write** (wystarcza do `repository_dispatch`).

### Konfiguracja po stronie Supabase (jednorazowo)

W *Project Settings → Edge Functions → Secrets* dodaj:

| Sekret | Wartość |
|---|---|
| `GITHUB_REPO` | `damian-barabash/softcar` |
| `GITHUB_TOKEN` | token z punktu 4 powyżej |

Ustawione już wcześniej: `RESEND_API_KEY`, `CONTACT_TO`, `CONTACT_FROM`, `IP_SALT`.

### DNS dla softcar.pl

| Typ | Nazwa | Wartość |
|---|---|---|
| A | `@` | `185.199.108.153` |
| A | `@` | `185.199.109.153` |
| A | `@` | `185.199.110.153` |
| A | `@` | `185.199.111.153` |
| CNAME | `www` | `damian-barabash.github.io.` |

Do czasu wpięcia domeny podgląd github.io nie zadziała poprawnie (ścieżki zasobów zaczynają się
od `/`), więc do testów używaj `npm run dev`.

---

## Panel `/admin`

Logowanie kontem Supabase Auth. Pierwsze utworzone konto dostaje rolę **właściciela**, kolejne —
**redaktora** (trigger `handle_new_admin`). Konta zakłada się w panelu Supabase:
*Authentication → Users → Add user*.

Zakładki:

- **Pulpit** — skróty, ostatnie zgłoszenia, przycisk „Opublikuj zmiany”.
- **Strona główna** — slider, sekcja „O nas”, wyróżniki, pasek przewijany, liczniki,
  sekcja kontaktowa, kafelki oferty, bloki ogłoszeń.
- **Strony** — treść wszystkich podstron (O nas, Oferta, Cennik, Kontakt, usługi, dokumenty prawne)
  wraz z SEO i banerem.
- **Menu** — menu główne (z podpozycjami) i menu w stopce.
- **Galeria** — zdjęcia pokazywane na stronie „O nas”.
- **Zgłoszenia** — CRM: statusy (nowe / w kontakcie / wycena / zamknięte / spam), notatki, eksport CSV.
- **Ustawienia** — dane firmy, social media, SEO, formularz kontaktowy, logo.
- **Użytkownicy** — dostęp do panelu oraz archiwum kont ze starej Joomli.
- **Pliki** — biblioteka mediów (Supabase Storage).

Edytor treści działa na `contenteditable` i ma tryb **„Kod HTML”**. Wybór jest świadomy: treści
przeniesione ze starej strony zawierają siatkę Bootstrapa i style inline (np. tabele cennika),
które edytor z własnym schematem (TipTap/ProseMirror) skasowałby przy pierwszym zapisie.

---

## Struktura repozytorium

```
.github/workflows/deploy.yml   budowanie i publikacja na GitHub Pages
public/                        zasoby statyczne (obrazy, czcionki, js frontu, CNAME, robots)
src/
  components/                  komponenty strony publicznej (nagłówek, stopka, sekcje)
  layouts/Base.astro           szkielet HTML, SEO, dane strukturalne
  pages/                       trasy: /, /[slug], /oferta/[slug], /cennik, /kontakt, /404, /admin
  admin/                       panel CMS (React)
  styles/legacy*.css           style przeniesione ze starego serwisu (generowane skryptem)
  lib/                         klient Supabase i wczytywanie treści przy budowaniu
scripts/
  build-legacy-css.py          skleja arkusze starego serwisu w jeden plik
  build-seed.py                jednorazowy import treści ze starej strony
  restructure-settings.py      rozbicie sekcji strony głównej na pola
  qc.mjs                       kontrola wyniku budowania
supabase/
  migrations/                  schemat bazy i dane początkowe
  functions/contact            formularz → tabela leads → e-mail (Resend)
  functions/publish            „Opublikuj zmiany” → GitHub Actions
```

---

## Do sprawdzenia z klientem

1. **Zgoda RODO i dokumenty prawne** przeniesione ze starej strony wskazują jako administratora
   danych *KROPLA ZDROWIA sp. z o.o., ul. Strażacka 81, Bielsko-Biała* oraz adres
   `kroplazdrowiapl@gmail.com` — to pozostałość po szablonie poprzedniej agencji, nie dane
   Soft Car Service. Dotyczy: formularza kontaktowego, „Polityki prywatności”, „Polityki Cookies”
   i „Obowiązku informacyjnego”. Treści są edytowalne w panelu.
2. **Godziny otwarcia 8.00–23.00** — tak było na starej stronie; warto potwierdzić.
3. **Dwa kafelki oferty** („Naprawy układu hamulcowego”, „Usługi elektryka samochodowego”) na starej
   stronie prowadziły pod adresy zwracające 404. Tutaj mają własne podstrony z treścią odzyskaną
   z bazy Joomli.
