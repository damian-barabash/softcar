-- Klasy .blockNNN pochodza ze starego szablonu i niosa style (tla, kolory).
-- Trzymamy je w bazie, zeby wyglad pozostal 1:1 takze dla pozycji dodanych pozniej.
alter table public.offer_tiles add column if not exists css_block int not null default 1554;
alter table public.info_boxes add column if not exists css_block int not null default 1784;
alter table public.counters   add column if not exists css_block int not null default 954;
alter table public.slides     add column if not exists css_slide int not null default 32;

update public.offer_tiles t set css_block = v.b
from (values (1,1554),(2,1635),(3,1806),(4,1807),(5,1816),(6,1636),(7,1780),(8,1782),(9,1783)) as v(n,b)
where t.sort = v.n * 10;

update public.info_boxes t set css_block = v.b
from (values (1,1785),(2,1818),(3,1784)) as v(n,b) where t.sort = v.n * 10;

update public.counters t set css_block = v.b
from (values (1,954),(2,955),(3,956)) as v(n,b) where t.sort = v.n * 10;

update public.slides t set css_slide = v.b
from (values (1,32),(2,26),(3,25)) as v(n,b) where t.sort = v.n * 10;
