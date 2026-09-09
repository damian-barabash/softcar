-- przycisk byl w tresci i dodatkowo jako osobne pole -> usuwamy z tresci
update public.settings
set value = jsonb_set(value, '{body_html}',
      to_jsonb(regexp_replace(value->>'body_html', '<a href="[^"]*" class="btn[^"]*">.*?</a>', '', 'g')))
where key = 'home_parallax';

-- blok "geometria" ma obrazek po lewej
update public.info_boxes set image_side = 'left' where css_block = 1785;
