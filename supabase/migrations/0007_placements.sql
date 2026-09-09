-- Gdzie dana pozycja ma sie pojawic
alter table public.offer_tiles add column if not exists placement text not null default 'home'
  check (placement in ('home','oferta'));
alter table public.info_boxes  add column if not exists placement text not null default 'home'
  check (placement in ('home','pages','both'));

-- blok "auto zastepcze" wyswietlal sie takze pod trescia kazdej podstrony
update public.info_boxes set placement='both' where css_block = 1818;

-- kafelki na stronie /oferta (inna kolejnosc i inne klasy niz na stronie glownej)
insert into public.offer_tiles (image, image_alt, title, href, sort, css_block, placement, is_published) values
 ('/images/design/box-offer-l.webp','Dokręcanie śruby','Mechanika oraz diagnostyka samochodowa','/oferta/mechanika-oraz-diagnostyka-samochodowa',10,1691,'oferta',true),
 ('/images/design/box-offer-l-1.webp','Układ hamulcowy','Naprawy układu hamulcowego','/oferta/naprawy-ukladu-hamulcowego',20,1692,'oferta',true),
 ('/images/design/box-offer-l-klimatyzacja.webp','Serwis klimatyzacji samochodowej','Serwis klimatyzacji samochodowej','/oferta/serwis-klimatyzacji-samochodowej',30,1808,'oferta',true),
 ('/images/design/box-offer-l-przechowywanie-opon.webp','Sezonowe przechowywanie opon','Sezonowe przechowywanie opon','/oferta/sezonowe-przechowywanie-opon',40,1809,'oferta',true),
 ('/images/design/box-offer-l-1-1-1-1.webp','Usługi elektryka samochodowego','Usługi elektryka samochodowego','/oferta/uslugi-elektryka-samochodowego',50,1810,'oferta',true),
 ('/images/design/box-offer-l-ustawianie-zbieznosci-kol.webp','Ustawianie geometrii i zbieżności kół','Ustawianie geometrii i zbieżności kół','/oferta/ustawianie-geometrii-i-zbieznosci-kol',60,1811,'oferta',true),
 ('/images/design/box-offer-l-naprawa-zawieszenia-i-silnikow.webp','Naprawa zawieszenia i silników','Naprawa zawieszenia i silników','/oferta/naprawa-zawieszenia-i-silnikow',70,1693,'oferta',true),
 ('/images/design/box-offer-l-1-1.webp','Opony','Wulkanizacja i wymiana opon','/oferta/sezonowe-przechowywanie-opon',80,1781,'oferta',true);
