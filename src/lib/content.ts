import { supabase } from './supabase';

export type MenuItem = { id: number; location: string; parent_id: number | null; label: string; href: string; target: string; sort: number; children?: MenuItem[] };
export type Page = { id: number; slug: string; kind: string; title: string; h1: string | null; meta_title: string | null; meta_desc: string | null; banner_image: string | null; body_html: string; sort: number };
export type Slide = { id: number; image: string | null; kicker: string | null; title: string | null; body_html: string | null; button_label: string | null; button_href: string | null; css_slide: number };
export type InfoBox = { id: number; title: string | null; body_html: string; image: string | null; image_side: string; visibility: string; css_block: number; placement: string };
export type Usp = { id: number; icon: string | null; icon_alt: string | null; label: string };
export type Counter = { id: number; value: number; suffix: string | null; label: string; css_block: number };
export type OfferTile = { id: number; image: string | null; image_alt: string | null; title: string; href: string; css_block: number; placement: string };
export type GalleryImage = { id: number; url: string; thumb: string | null; alt: string | null };

let cache: Awaited<ReturnType<typeof loadAll>> | null = null;

async function loadAll() {
  const [settings, menu, pages, slides, infoBoxes, usp, counters, offer, gallery] =
    await Promise.all([
      supabase.from('settings').select('key,value'),
      supabase.from('menu_items').select('*').order('sort'),
      supabase.from('pages').select('*').order('sort'),
      supabase.from('slides').select('*').order('sort'),
      supabase.from('info_boxes').select('*').order('sort'),
      supabase.from('usp_items').select('*').order('sort'),
      supabase.from('counters').select('*').order('sort'),
      supabase.from('offer_tiles').select('*').order('sort'),
      supabase.from('gallery_images').select('*').order('sort'),
    ]);

  for (const r of [settings, menu, pages, slides, infoBoxes, usp, counters, offer, gallery]) {
    if (r.error) throw new Error(`Supabase: ${r.error.message}`);
  }

  const S: Record<string, any> = {};
  for (const row of settings.data ?? []) S[row.key] = row.value;

  const tree = (loc: string) => {
    const items = (menu.data ?? []).filter((m: any) => m.location === loc) as MenuItem[];
    const roots = items.filter((m) => !m.parent_id);
    for (const r of roots) r.children = items.filter((m) => m.parent_id === r.id);
    return roots;
  };

  return {
    settings: S,
    headerMenu: tree('header'),
    footerMenu: tree('footer'),
    pages: (pages.data ?? []) as Page[],
    slides: (slides.data ?? []) as Slide[],
    infoBoxes: (infoBoxes.data ?? []) as InfoBox[],
    usp: (usp.data ?? []) as Usp[],
    counters: (counters.data ?? []) as Counter[],
    offer: (offer.data ?? []) as OfferTile[],
    gallery: (gallery.data ?? []) as GalleryImage[],
  };
}

export async function getContent() {
  if (!cache) cache = await loadAll();
  return cache;
}

export async function getPage(slug: string) {
  const c = await getContent();
  const p = c.pages.find((x) => x.slug === slug);
  if (!p) throw new Error(`Brak strony "${slug}" w bazie`);
  return p;
}
