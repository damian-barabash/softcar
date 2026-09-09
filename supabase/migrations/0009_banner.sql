-- w starym serwisie kazda podstrona miala ten sam baner
update public.pages set banner_image = '/images/design/banner.webp';
update public.settings set value = value || '{"banner_alt":"Klucze w ręce"}'::jsonb where key='branding';
