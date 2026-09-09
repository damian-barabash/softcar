-- Cennik w starym serwisie to zwykly artykul z wlasnym ukladem kolumn (col-md-8, obrazki),
-- a nie zbior danych. Rozbicie go na tabele zmienialo wyglad, wiec wraca jako strona
-- edytowana w edytorze tresci — tak jak dotad robil to klient w Joomli.
drop table if exists public.price_rows;
drop table if exists public.price_sections;
