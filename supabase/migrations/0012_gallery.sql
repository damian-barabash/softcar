-- galeria wchodzi do CMS jako osobna lista zdjec; w tresci strony zostaje znacznik
alter table public.gallery_images add column if not exists thumb text;
update public.gallery_images set
  url   = '/images/galerie/35/' || split_part(url, '/', 5),
  thumb = '/images/galerie/35/thumbnails/' || replace(split_part(url, '/', 5), '.webp', '.jpg')
where url like '/images/galerie/35/%';
update public.gallery_images set url = replace(url, '.webp', '.jpg') where url like '%.webp';

update public.pages
set body_html = regexp_replace(body_html,
      '<div id="droppicsgallery35"[\s\S]*?</div>\s*</div>\s*</div>', '<!--GALERIA-->', 'g')
where slug = 'o-nas';
