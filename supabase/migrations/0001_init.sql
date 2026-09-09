-- ============================================================
-- SOFTCAR — schemat bazy (CMS + CRM)
-- ============================================================

create extension if not exists "pgcrypto";

-- ---------- role administracyjne ----------
create table if not exists public.admin_users (
  id          uuid primary key references auth.users(id) on delete cascade,
  email       text not null,
  full_name   text,
  role        text not null default 'editor' check (role in ('owner','editor')),
  created_at  timestamptz not null default now()
);

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.admin_users where id = auth.uid());
$$;

create or replace function public.is_owner()
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.admin_users where id = auth.uid() and role = 'owner');
$$;

-- ---------- ustawienia globalne ----------
create table if not exists public.settings (
  key         text primary key,
  value       jsonb not null default '{}'::jsonb,
  group_name  text not null default 'ogolne',
  label       text,
  updated_at  timestamptz not null default now()
);

-- ---------- menu ----------
create table if not exists public.menu_items (
  id           bigserial primary key,
  location     text not null check (location in ('header','footer')),
  parent_id    bigint references public.menu_items(id) on delete cascade,
  label        text not null,
  href         text not null default '#',
  target       text not null default '_self' check (target in ('_self','_blank')),
  sort         int  not null default 0,
  is_published boolean not null default true
);
create index if not exists menu_items_loc_idx on public.menu_items(location, sort);

-- ---------- strony ----------
create table if not exists public.pages (
  id            bigserial primary key,
  slug          text not null unique,
  kind          text not null default 'page' check (kind in ('page','service','legal')),
  title         text not null,
  h1            text,
  meta_title    text,
  meta_desc     text,
  banner_image  text,
  body_html     text not null default '',
  sort          int not null default 0,
  is_published  boolean not null default true,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);
create index if not exists pages_kind_idx on public.pages(kind, sort);

-- ---------- slider ----------
create table if not exists public.slides (
  id            bigserial primary key,
  image         text,
  kicker        text,
  title         text,
  subtitle      text,
  body_html     text,
  button_label  text,
  button_href   text,
  sort          int not null default 0,
  is_published  boolean not null default true
);

-- ---------- bloki informacyjne na stronie glownej ----------
create table if not exists public.info_boxes (
  id            bigserial primary key,
  title         text,
  body_html     text not null default '',
  image         text,
  image_side    text not null default 'right' check (image_side in ('left','right','none')),
  sort          int not null default 0,
  is_published  boolean not null default true
);

-- ---------- USP ----------
create table if not exists public.usp_items (
  id     bigserial primary key,
  icon   text,
  label  text not null,
  sort   int not null default 0
);

-- ---------- liczniki ----------
create table if not exists public.counters (
  id     bigserial primary key,
  value  int not null default 0,
  suffix text default '',
  label  text not null,
  sort   int not null default 0
);

-- ---------- kafelki oferty ----------
create table if not exists public.offer_tiles (
  id            bigserial primary key,
  image         text,
  image_alt     text,
  title         text not null,
  href          text not null default '#',
  sort          int not null default 0,
  is_published  boolean not null default true
);

-- ---------- galeria ----------
create table if not exists public.gallery_images (
  id     bigserial primary key,
  url    text not null,
  alt    text,
  sort   int not null default 0
);

-- ---------- cennik ----------
create table if not exists public.price_sections (
  id          bigserial primary key,
  title       text not null,
  intro_html  text default '',
  columns     jsonb not null default '["Usługa","Cena"]'::jsonb,
  sort        int not null default 0,
  is_published boolean not null default true
);
create table if not exists public.price_rows (
  id          bigserial primary key,
  section_id  bigint not null references public.price_sections(id) on delete cascade,
  cells       jsonb not null default '[]'::jsonb,
  sort        int not null default 0
);
create index if not exists price_rows_section_idx on public.price_rows(section_id, sort);

-- ---------- CRM: zgloszenia z formularza ----------
create table if not exists public.leads (
  id          bigserial primary key,
  name        text,
  email       text,
  phone       text,
  message     text,
  source      text not null default 'kontakt',
  status      text not null default 'nowy' check (status in ('nowy','w_kontakcie','wycena','zamkniety','spam')),
  note        text,
  ip_hash     text,
  user_agent  text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists leads_status_idx on public.leads(status, created_at desc);

-- ---------- archiwum uzytkownikow ze starej Joomli ----------
create table if not exists public.legacy_users (
  id            bigint primary key,
  name          text,
  username      text,
  email         text,
  group_name    text,
  register_date timestamptz,
  last_visit    timestamptz,
  blocked       boolean not null default false,
  note          text,
  imported_at   timestamptz not null default now()
);

-- ---------- media wgrane przez CMS ----------
create table if not exists public.media (
  id          bigserial primary key,
  path        text not null unique,
  url         text not null,
  alt         text,
  width       int,
  height      int,
  size_bytes  bigint,
  created_at  timestamptz not null default now()
);

-- ---------- dziennik zmian ----------
create table if not exists public.audit_log (
  id          bigserial primary key,
  actor       text,
  action      text not null,
  entity      text not null,
  entity_id   text,
  payload     jsonb,
  created_at  timestamptz not null default now()
);
create index if not exists audit_log_created_idx on public.audit_log(created_at desc);

-- ---------- updated_at ----------
create or replace function public.touch_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end $$;

drop trigger if exists pages_touch on public.pages;
create trigger pages_touch before update on public.pages
  for each row execute function public.touch_updated_at();
drop trigger if exists leads_touch on public.leads;
create trigger leads_touch before update on public.leads
  for each row execute function public.touch_updated_at();

-- ============================================================
-- RLS
-- ============================================================
alter table public.admin_users     enable row level security;
alter table public.settings        enable row level security;
alter table public.menu_items      enable row level security;
alter table public.pages           enable row level security;
alter table public.slides          enable row level security;
alter table public.info_boxes      enable row level security;
alter table public.usp_items       enable row level security;
alter table public.counters        enable row level security;
alter table public.offer_tiles     enable row level security;
alter table public.gallery_images  enable row level security;
alter table public.price_sections  enable row level security;
alter table public.price_rows      enable row level security;
alter table public.leads           enable row level security;
alter table public.legacy_users    enable row level security;
alter table public.media           enable row level security;
alter table public.audit_log       enable row level security;

-- publiczny odczyt tylko tresci opublikowanych
create policy p_settings_read       on public.settings       for select using (true);
create policy p_menu_read           on public.menu_items     for select using (is_published);
create policy p_pages_read          on public.pages          for select using (is_published);
create policy p_slides_read         on public.slides         for select using (is_published);
create policy p_info_read           on public.info_boxes     for select using (is_published);
create policy p_usp_read            on public.usp_items      for select using (true);
create policy p_counters_read       on public.counters       for select using (true);
create policy p_offer_read          on public.offer_tiles    for select using (is_published);
create policy p_gallery_read        on public.gallery_images for select using (true);
create policy p_price_sec_read      on public.price_sections for select using (is_published);
create policy p_price_rows_read     on public.price_rows     for select using (
  exists (select 1 from public.price_sections s where s.id = section_id and s.is_published));
create policy p_media_read          on public.media          for select using (true);

-- pelny dostep dla zalogowanych administratorow
do $$
declare t text;
begin
  foreach t in array array['settings','menu_items','pages','slides','info_boxes','usp_items','counters',
                           'offer_tiles','gallery_images','price_sections','price_rows','leads',
                           'legacy_users','media','audit_log']
  loop
    execute format('create policy p_%s_admin on public.%I for all to authenticated using (public.is_admin()) with check (public.is_admin())', t, t);
  end loop;
end $$;

-- admin_users: kazdy admin widzi liste, tylko owner zmienia
create policy p_admin_read  on public.admin_users for select to authenticated using (public.is_admin());
create policy p_admin_write on public.admin_users for all    to authenticated using (public.is_owner()) with check (public.is_owner());

-- leads: zapis wylacznie przez Edge Function (service_role omija RLS) — brak polityki insert dla anon
