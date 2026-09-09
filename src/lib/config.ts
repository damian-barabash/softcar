// Klucz "publishable" jest z zalozenia jawny — chroni nas RLS w bazie, nie tajnosc klucza.
// Klucz service_role NIGDY nie moze trafic do tego repozytorium ani do przegladarki.
//
// Uwaga: uzywamy `||`, a nie `??`. Zmienne z GitHub Actions przychodza jako PUSTY LANCUCH,
// gdy repozytorium nie ma ustawionej danej zmiennej — `??` przepuscilby taka pustke dalej
// i budowanie padalo na "supabaseUrl is required".
const env = import.meta.env;

export const SUPABASE_URL =
  env.PUBLIC_SUPABASE_URL || 'https://zqslfrjikxfmcubewfmk.supabase.co';
export const SUPABASE_ANON_KEY =
  env.PUBLIC_SUPABASE_ANON_KEY || 'sb_publishable_rivyDZ7aN9C_2JxMph4SWg_8I7z8vUH';
export const SITE_URL = 'https://softcar.pl';
