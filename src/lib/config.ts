// Klucz "publishable" jest z zalozenia jawny — chroni nas RLS w bazie, nie tajnosc klucza.
// Klucz service_role NIGDY nie moze trafic do tego repozytorium ani do przegladarki.
export const SUPABASE_URL =
  import.meta.env.PUBLIC_SUPABASE_URL ?? 'https://zqslfrjikxfmcubewfmk.supabase.co';
export const SUPABASE_ANON_KEY =
  import.meta.env.PUBLIC_SUPABASE_ANON_KEY ?? 'sb_publishable_rivyDZ7aN9C_2JxMph4SWg_8I7z8vUH';
export const SITE_URL = 'https://softcar.pl';
