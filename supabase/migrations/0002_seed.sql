-- SEED wygenerowany automatycznie (scripts/build-seed.py). Nie edytowac recznie.

begin;
delete from public.price_rows;
delete from public.price_sections;
delete from public.gallery_images;
delete from public.offer_tiles;
delete from public.counters;
delete from public.usp_items;
delete from public.info_boxes;
delete from public.slides;
delete from public.pages;
delete from public.menu_items;
delete from public.settings;
delete from public.legacy_users;

insert into public.settings(key,value,group_name,label) values ('company','{"name": "Soft Car Service", "street": "ul. Legionów 124", "zip": "43-502", "city": "Czechowice-Dziedzice", "phone": "+48 739 533 830", "phone_href": "tel:+48739533830", "email": "office.softcarservice@gmail.com", "hours": "8.00 - 23.00", "map_lat": 49.8978624, "map_lng": 19.0099803, "route_url": "https://www.google.com/maps/dir/?api=1&destination=49.8978624,19.0099803"}'::jsonb,'kontakt','Dane firmy');
insert into public.settings(key,value,group_name,label) values ('social','[{"label": "Facebook", "href": "https://www.facebook.com/softcarservice/", "icon": "/images/design/icon-facebook.svg"}, {"label": "Instagram", "href": "https://instagram.com/softcarservice?igshid=MzRlODBiNWFlZA==", "icon": "/images/design/icon-instagram.webp"}, {"label": "TikTok", "href": "https://www.tiktok.com/@softcarservice", "icon": "/images/design/tiktok-icon-circle-3.webp"}, {"label": "Google Maps", "href": "https://maps.app.goo.gl/vG1nH4xTRNGixdfe7", "icon": "/images/gmaps.webp"}]'::jsonb,'kontakt','Social media');
insert into public.settings(key,value,group_name,label) values ('branding','{"logo": "/images/design/logo.webp", "favicon": "/images/design/favicon.ico", "og_image": "/images/design/logo-soft-car-service.png", "banner": "/images/design/banner.webp"}'::jsonb,'ogolne','Logo i favicon');
insert into public.settings(key,value,group_name,label) values ('header_cta','[{"label": "WYZNACZ TRASĘ", "href": "https://www.google.com/maps/dir/?api=1&destination=49.8978624,19.0099803", "style": "ghost"}, {"label": "Zadzwoń", "href": "tel:+48739533830", "style": "solid"}]'::jsonb,'ogolne','Przyciski w nagłówku');
insert into public.settings(key,value,group_name,label) values ('home_about','{"html": "<div class=\"row\"><div class=\"col-md-3 col-sm-4\">\n<p class=\"mininaglowek\">O nas</p>\n<hr class=\"hr-zmienny-2\">\n</div></div>\n<div class=\"row\">\n<div class=\"col-md-8\">\n<h1>Warsztat samochodowy – Soft Car Service w&nbsp;Czechowicach-Dziedzicach</h1>\n<p>Soft Car Service to&nbsp;zaufany <strong>serwis samochodowy</strong>, który służy mieszkańcom Czechowic-Dziedzic i&nbsp;okolic. Specjalizujemy&nbsp;się w&nbsp;<a href=\"/oferta/mechanika-oraz-diagnostyka-samochodowa\">naprawie samochodów osobowych i&nbsp;dostawczych</a>, oferując szeroki zakres usług, od&nbsp;przeglądów technicznych po&nbsp;skomplikowane naprawy mechaniczne. Nasz&nbsp;zespół to&nbsp;doświadczeni mechanicy, którzy z&nbsp;pasją podchodzą do&nbsp;swojej pracy, gwarantując najwyższą jakość usług. Dzięki nowoczesnemu sprzętowi i&nbsp;ciągłemu doskonaleniu umiejętności jesteśmy w&nbsp;stanie sprostać największym wyzwaniom.</p>\n</div>\n<div class=\"col-md-4\"><div class=\"well well-2-30px\">\n<p class=\"text-stylekmlrhjv6\">Poznaj nas bliżej!</p>\n<hr>\n<p>Chcesz dowiedzieć&nbsp;się więcej o&nbsp;naszym autoserwisie i&nbsp;ofercie? Kliknij przycisk poniżej!</p>\n<p><a class=\"btn btn-default btn-default-size border-radius-sm btn-shadow\" href=\"/o-nas\">Dowiedz&nbsp;się o&nbsp;nas więcej</a></p>\n</div></div>\n</div>", "cta_html": "<p class=\"text-stylekmlrhjv6\">Poznaj nas bliżej!</p>\n<hr>\n<p>Chcesz dowiedzieć&nbsp;się więcej o&nbsp;naszym autoserwisie i&nbsp;ofercie? Kliknij przycisk poniżej!</p>\n<p><a class=\"btn btn-default btn-default-size border-radius-sm btn-shadow\" href=\"/o-nas\">Dowiedz&nbsp;się o&nbsp;nas więcej</a></p>"}'::jsonb,'strona-glowna','Strona główna — O nas');
insert into public.settings(key,value,group_name,label) values ('home_usp','{"heading_html": "<div class=\"row\"><div class=\"col-md-12\">\n<p class=\"mininaglowek\">To co nas wyróżnia</p>\n<hr class=\"hr-zmienny-2\">\n</div></div>"}'::jsonb,'strona-glowna','Strona główna — USP');
insert into public.settings(key,value,group_name,label) values ('home_marquee','{"text": "Współpracujemy z flotami samochodowymi. Zachęcamy do kontaktu!Współpracujemy z flotami samochodowymi. Zachęcamy do konta"}'::jsonb,'strona-glowna','Strona główna — pasek przewijany');
insert into public.settings(key,value,group_name,label) values ('home_counters','{"heading_html": "<div class=\"center\">\n\t\t\t\t\t\t\t\t\t\t\t\t\n\t<div class=\"row\"><div class=\"col-md-4 col-md-offset-4\">\n<p class=\"mininaglowek\">Nasze osiągnięcia</p>\n<hr class=\"hr-zmienny-2\">\n</div></div>\n<div class=\"row\"><div class=\"col-md-12\"><h2>Wieloletnie doświadczenie na rynku</h2></div></div>\n<div class=\"row\"><div class=\"col-md-12\"><p>Jesteśmy firmą z wieloletnim doświadczeniem na rynku. Przez lata zdobywaliśmy zaufanie klientów, którzy docenili nasze profesjonalne podejście do pracy. Nasze osiągnięcia to efekt ciężkiej pracy, pasji i zaangażowania. Dzięki temu możemy dzisiaj oferować usługi na najwyższym poziomie.</p></div></div>\n\t\t\t\t\t\t\n</div>"}'::jsonb,'strona-glowna','Strona główna — liczniki');
insert into public.settings(key,value,group_name,label) values ('home_parallax','{"heading_html": "<div class=\"row\"><div class=\"col-md-12\"><h2>Zapraszamy do&nbsp;kontaktu!</h2></div></div>", "body_html": "<div class=\"row\"><div class=\"col-md-12\"><p><strong>Jeżeli macie jakiekolwiek pytania lub&nbsp;potrzebujecie dodatkowych informacji, zapraszamy do&nbsp;skontaktowania&nbsp;się z&nbsp;nami. Jesteśmy gotowi udzielić wszelkich wyjaśnień i&nbsp;przygotować spersonalizowaną wycenę, dopasowaną do&nbsp;Waszych potrzeb.</strong></p></div></div>\n<div class=\"button\"><a href=\"/o-nas\" class=\"btn border-radius-sm btn-shadow\">Skontaktuj&nbsp;się z&nbsp;nami</a></div>", "button": {"label": "Skontaktuj się z nami", "href": "/o-nas"}}'::jsonb,'strona-glowna','Strona główna — paralaksa');
insert into public.settings(key,value,group_name,label) values ('home_offer','{"heading_html": "<div class=\"center\">\n\t\t\t\t\t\t\t\t\t\t\t\t\n\t<div class=\"row\"><div class=\"col-md-3 col-sm-4\">\n<p class=\"mininaglowek\">Oferta</p>\n<hr class=\"hr-zmienny-2\">\n</div></div>\n<div class=\"row\"><div class=\"col-md-12\"><h2 style=\"\">Zapraszamy do zapoznania się z naszą ofertą. Gwarantujemy profesjonalne usługi na&nbsp;najwyższym poziomie.</h2></div></div>\n\t\t\t\t\t\t\n</div>"}'::jsonb,'strona-glowna','Strona główna — nagłówek oferty');
insert into public.settings(key,value,group_name,label) values ('footer','{"copyright_html": "<p>Wszelkie prawa zastrzeżone © {year} Soft Car Service</p>", "legal_links": [{"label": "Polityka prywatności", "href": "/polityka-prywatnosci"}, {"label": "Polityka Cookies", "href": "/polityka-cookies"}]}'::jsonb,'ogolne','Stopka');
insert into public.settings(key,value,group_name,label) values ('seo','{"title": "Serwis Samochodowy – Soft Car Service w Czechowicach-Dziedzicach", "description": "Soft Car Service – Twój zaufany serwis samochodowy w Czechowicach-Dziedzicach. Specjalizujemy się między innymi w naprawie samochodów osobowych i dostawczych.", "site_name": "Soft Car Service", "locale": "pl_PL"}'::jsonb,'ogolne','SEO');
insert into public.settings(key,value,group_name,label) values ('contact_form','{"to": "office.softcarservice@gmail.com", "subject": "Nowa wiadomość ze strony softcar.pl", "success": "Dziękujemy! Wiadomość została wysłana.", "rodo": "Wyrażam zgodę na przetwarzanie moich danych osobowych w celu odpowiedzi na zapytanie."}'::jsonb,'kontakt','Formularz kontaktowy');

with h as (
  insert into public.menu_items(location,label,href,sort) values
    ('header','Strona główna','/',10),('header','O nas','/o-nas',20),('header','Oferta','/oferta',30),
    ('header','Cennik','/cennik',40),('header','Kontakt','/kontakt',50)
  returning id,label)
insert into public.menu_items(location,parent_id,label,href,sort)
select 'header',(select id from h where label='Oferta'),v.label,v.href,v.sort from (values
  ('Mechanika oraz diagnostyka samochodowa','/oferta/mechanika-oraz-diagnostyka-samochodowa',10),
  ('Naprawy układu hamulcowego','/oferta/naprawy-ukladu-hamulcowego',20),
  ('Naprawa zawieszenia i silników','/oferta/naprawa-zawieszenia-i-silnikow',30),
  ('Serwis klimatyzacji samochodowej','/oferta/serwis-klimatyzacji-samochodowej',40),
  ('Sezonowe przechowywanie opon','/oferta/sezonowe-przechowywanie-opon',50),
  ('Usługi elektryka samochodowego','/oferta/uslugi-elektryka-samochodowego',60),
  ('Profesjonalna konserwacja podwozia','/oferta/profesjonalna-konserwacja-podwozia',70),
  ('Ustawianie geometrii i zbieżności kół','/oferta/ustawianie-geometrii-i-zbieznosci-kol',80),
  ('Auto zastępcze','/oferta/auto-zastepcze',90)
) as v(label,href,sort);
insert into public.menu_items(location,label,href,sort) values ('footer','Strona główna','/',10);
insert into public.menu_items(location,label,href,sort) values ('footer','O nas','/o-nas',20);
insert into public.menu_items(location,label,href,sort) values ('footer','Oferta','/oferta',30);
insert into public.menu_items(location,label,href,sort) values ('footer','Cennik','/cennik',40);
insert into public.menu_items(location,label,href,sort) values ('footer','Kontakt','/kontakt',50);

insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('o-nas','page','O nas','O naszym warsztacie samochodowym w Czechowicach-Dziedzicach','O serwisie Soft Car Service w Czechowicach-Dziedzicach','Poznaj Soft Car Service, profesjonalny serwis samochodowy zlokalizowany w Czechowicach-Dziedzicach. Więcej szczegółów na naszej stronie internetowej!','/images/design/banner.webp','<div class="row"><div class="col-md-12"><h1>O naszym warsztacie samochodowym w&nbsp;Czechowicach-Dziedzicach</h1></div></div>
<div class="row"><div class="col-md-12">
<p><strong>Soft Car Service</strong> to&nbsp;zaufany serwis samochodowy, który służy mieszkańcom Czechowic-Dziedzic i&nbsp;okolic. Specjalizujemy&nbsp;się w&nbsp;naprawie samochodów osobowych i&nbsp;dostawczych, oferując szeroki zakres usług, od&nbsp;przeglądów technicznych po&nbsp;skomplikowane naprawy mechaniczne.</p>
<p>Nasza misja to&nbsp;zapewnienie najwyższej jakości usług serwisowych, które przekraczają oczekiwania naszych klientów. Wierzymy, że nasza pasja do&nbsp;samochodów i&nbsp;doświadczenie w&nbsp;branży motoryzacyjnej przekładają&nbsp;się na&nbsp;doskonałe rezultaty pracy.</p>
</div></div>
<div class="row">
<div class="col-md-8 margin-top-xl-lg-md margin-top-sm margin-top-xs brr-md-img shadow-img-1"><p><img src="/images/design/softcar.jpg" alt="Mechanik z&nbsp;tabletem" width="1063" height="800"></p></div>
<div class="col-md-4 well-2 margin-top-xl-lg-md margin-top-sm margin-top-xs">
<p>Nasza ekipa składa&nbsp;się z&nbsp;<strong>wykwalifikowanych mechaników samochodowych</strong>, którzy stale podnoszą swoje kwalifikacje, aby sprostać najnowszym trendom i&nbsp;technologiom w&nbsp;branży motoryzacyjnej. Dzięki temu jesteśmy w&nbsp;stanie naprawić każdy samochód, niezależnie od&nbsp;marki, modelu czy&nbsp;roku produkcji. Stawiamy na&nbsp;uczciwość i&nbsp;transparentność. Przed przystąpieniem do&nbsp;naprawy zawsze informujemy klienta o&nbsp;przewidywanym koszcie i&nbsp;czasie realizacji usługi.</p>
<p>Siedziba serwisu samochodowego znajduje&nbsp;się przy <strong>ulicy Legionów 124 w&nbsp;Czechowicach-Dziedzicach</strong>. Serdecznie zapraszamy do&nbsp;odwiedzenia i&nbsp;skorzystania z&nbsp;naszych usług. Z&nbsp;Soft Car Service Twoje auto jest zawsze w&nbsp;dobrych rękach.</p>
</div>
</div>
<div class="row"><div class="col-md-12">
<div><hr></div>
<div>
<div id="droppicsgallery35" class="droppicsgallery droppicsgallerymasonry 0"><div class="droppicspictures" style="position: relative; width: 1050px; height: 453.14px;">
<div class="wimg" style="position: absolute; left: 0px; top: 0px;"><a class="vbox-item" href="/images/galerie/35/softcar-1.jpg"><img class="img76 img" src="/images/galerie/35/thumbnails/softcar-1.jpg" alt="softcar-1" title=""></a></div>
<div class="wimg" style="position: absolute; left: 210px; top: 0px;"><a class="vbox-item" href="/images/galerie/35/softcar-2.jpg"><img class="img77 img" src="/images/galerie/35/thumbnails/softcar-2.jpg" alt="softcar-2" title=""></a></div>
<div class="wimg" style="position: absolute; left: 420px; top: 0px;"><a class="vbox-item" href="/images/galerie/35/softcar-3.jpg"><img class="img78 img" src="/images/galerie/35/thumbnails/softcar-3.jpg" alt="softcar-3" title=""></a></div>
<div class="wimg" style="position: absolute; left: 630px; top: 0px;"><a class="vbox-item" href="/images/galerie/35/softcar-4.jpg"><img class="img79 img" src="/images/galerie/35/thumbnails/softcar-4.jpg" alt="softcar-4" title=""></a></div>
<div class="wimg" style="position: absolute; left: 840px; top: 0px;"><a class="vbox-item" href="/images/galerie/35/softcar-5.jpg"><img class="img80 img" src="/images/galerie/35/thumbnails/softcar-5.jpg" alt="softcar-5" title=""></a></div>
<div class="wimg" style="position: absolute; left: 210px; top: 122px;"><a class="vbox-item" href="/images/galerie/35/softcar-6.jpg"><img class="img81 img" src="/images/galerie/35/thumbnails/softcar-6.jpg" alt="softcar-6" title=""></a></div>
<div class="wimg" style="position: absolute; left: 420px; top: 177px;"><a class="vbox-item" href="/images/galerie/35/softcar-7.jpg"><img class="img82 img" src="/images/galerie/35/thumbnails/softcar-7.jpg" alt="softcar-7" title=""></a></div>
<div class="wimg" style="position: absolute; left: 0px; top: 275px;"><a class="vbox-item" href="/images/galerie/35/softcar-9.jpg"><img class="img83 img" src="/images/galerie/35/thumbnails/softcar-9.jpg" alt="softcar-9" title=""></a></div>
<div class="wimg" style="position: absolute; left: 630px; top: 275px;"><a class="vbox-item" href="/images/galerie/35/softcar-8.jpg"><img class="img84 img" src="/images/galerie/35/thumbnails/softcar-8.jpg" alt="softcar-8" title=""></a></div>
<div class="wimg" style="position: absolute; left: 840px; top: 275px;"><a class="vbox-item" href="/images/galerie/35/softcar-10.jpg"><img class="img85 img" src="/images/galerie/35/thumbnails/softcar-10.jpg" alt="softcar-10" title=""></a></div>
<div class="wimg" style="position: absolute; left: 210px; top: 283px;"><a class="vbox-item" href="/images/galerie/35/softcar-11.jpg"><img class="img86 img" src="/images/galerie/35/thumbnails/softcar-11.jpg" alt="softcar-11" title=""></a></div>
</div></div>
<div class="clr"></div>

</div>
<div><hr></div>
</div></div>',0,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('oferta','page','Oferta','Nasze usługi w zakresie serwisu i naprawy samochodów','Usługi samochodowe – serwis samochodów osobowych oraz dostawczych','Zapoznaj się z naszą ofertą usług samochodowych, która obejmuje szeroki zakres napraw mechanicznych, diagnostyki samochodowej oraz serwisu układu hamulcowego.','/images/design/content-oferta.webp','<div class="row" disabled=""><div class="col-md-12" disabled=""><h1>Nasze usługi w&nbsp;zakresie serwisu i&nbsp;naprawy samochodów</h1></div></div>
<div class="row" disabled="">
<div class="col-md-4 well-2 margin-top-xl-lg-md margin-top-sm margin-top-xs" disabled="">
<p>Oferujemy szeroki zakres usług samochodowych związanych z&nbsp;naprawą i&nbsp;serwisem pojazdów osobowych oraz&nbsp;dostawczych. Nasza oferta obejmuje przeglądy samochodów, wymianę oleju i&nbsp;filtrów, serwisowanie układu hamulcowego, klimatyzacji samochodowej i&nbsp;naprawę silnika. Dodatkowo oferujemy ustawienie geometrii i&nbsp;zbieżności kół oraz&nbsp;usługi związane z&nbsp;naprawą układu hamulcowego i&nbsp;zawieszenia. <br>Ponadto zajmujemy&nbsp;się wulkanizacją i&nbsp;wymianą opon dla flot samochodowych. Zespół składa&nbsp;się z&nbsp;doświadczonych mechaników, którzy zawsze służą pomocą i&nbsp;doradztwem. Dbamy o&nbsp;to, aby nasze usługi były na&nbsp;najwyższym poziomie, a&nbsp;nasi klienci zawsze zadowoleni.</p>
<p>&nbsp;</p>
</div>
<div class="col-md-8 margin-top-xl-lg-md margin-top-sm margin-top-xs brr-md-img shadow-img-1 margin-bottom-sm margin-bottom-xl-lg-md margin-bottom-xs" disabled=""><p disabled=""><img src="/images/design/content-oferta.webp" alt="Klucz i&nbsp;silnik" width="770" height="500" disabled=""></p></div>
</div>
<div class="row"><div class="col-md-12">
<ul style="columns: 2;">
<li>Diagnostyka</li>
<li>Diagnostyka komputerowa</li>
<li>Diagnostyka przed zakupem</li>
<li>Diagnostyka zawieszenia</li>
<li>Diagnostyka silnika</li>
<li>Diagnostyka układu hamulcowego</li>
<li>Diagnostyka skrzyni biegów</li>
<li>Diagnostyka układu paliwowego</li>
<li>Diagnostyka układu klimatyzacji</li>
<li>Serwisowanie</li>
<li>Wymiana oleju silnikowego, w&nbsp;skrzyni biegów</li>
<li>Wymiana płynów technicznych</li>
<li>Dobór części samochodowych</li>
<li>Naprawa zawieszenia</li>
<li>Naprawa silnika</li>
<li>Wymiana rozrusznika i&nbsp;alternatora</li>
<li>Naprawa układu hamulcowego</li>
<li>Wymiana zębatki kierowniczej</li>
<li>Naprawa skrzyni biegów (manual)</li>
<li>Naprawa układu paliwowego</li>
<li>Naprawa instalacji elektrycznej</li>
<li>Naprawa układu wydechowego</li>
<li>Regulacja reflektorów</li>
<li>Płukanie układu chłodzenia</li>
<li>Serwis klimatyzacji (uzupełnienie, diagnostyka, naprawa)</li>
<li>Wymiana rozrządu</li>
<li>Konserwacja podwozia</li>
<li>Ustawienie zbieżności kół</li>
</ul>
<p>&nbsp;</p>
</div></div>',0,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('cennik','page','Cennik','Cennik usług - Soft Car Service','Cennik usług Soft Car Service - Dostępne opcje dla Ciebie','Sprawdź nasz cennik usług. Soft Car Service oferuje konkurencyjne ceny na szeroki zakres usług motoryzacyjnych. Zapraszamy po więcej szczegółów na naszą stronę!','/images/design/content-cennik.webp','<div class="row" disabled=""><div class="col-md-12" disabled=""><h1>Cennik usług - Soft Car Service</h1></div></div>
<div class="row" disabled="">
<div class="col-md-6" disabled="">
<p>Soft Car Service to&nbsp;profesjonalny <strong>serwis samochodowy </strong>specjalizujący&nbsp;się w&nbsp;kompleksowej obsłudze pojazdów. Oferujemy szeroki zakres usług z&nbsp;obszaru <strong>mechaniki pojazdowej, </strong>w tym przeglądy techniczne, <strong>diagnostykę komputerową,</strong> naprawy układu hamulcowego oraz&nbsp;inne naprawy eksploatacyjne.</p>
<p>Naszym priorytetem jest wysoka jakość usług, transparentne zasady współpracy oraz&nbsp;uczciwe podejście do&nbsp;każdego klienta. Ceny usług są jasno określone i&nbsp;ustalane indywidualnie w&nbsp;zależności od&nbsp;modelu pojazdu oraz&nbsp;stopnia skomplikowania naprawy.</p>
<h2>
<br>Cennik robocizny</h2>
<ul>
<li>
<strong>180&nbsp;zł brutto / godzina</strong> – samochody osobowe</li>
<li>
<strong>220&nbsp;zł brutto / godzina </strong>– samochody dostawcze, busy.</li>
</ul>
<p>Każde zlecenie wyceniamy indywidualnie po&nbsp;wstępnej diagnostyce lub&nbsp;konsultacji, aby zapewnić możliwie najbardziej precyzyjny koszt naprawy.</p>
<p>W Soft Car Service naprawiamy samochody wszystkich marek i&nbsp;dajemy gwarancję na&nbsp;wykonane prace oraz&nbsp;zakupione u&nbsp;nas części.&nbsp;<br><br></p>
<p>Skontaktuj&nbsp;się z&nbsp;nami pod&nbsp;numerem tel. <a href="tel:739533830">739 533 830</a> lub&nbsp;mailowo:&nbsp;<a href="mailto:office.softcarservice@gmail.com">office.softcarservice@gmail.com</a>.</p>
<p>&nbsp;</p>
</div>
<div class="margin-bottom-sm margin-bottom-xs col-md-6" disabled=""><p style="text-align: center;" disabled=""><img class="" src="/images/design/content-cennik.webp" alt="Podawanie karty" width="770" height="500" disabled=""></p></div>
</div>
<div class="row"><div class="col-md-12">
<hr>
<h3><strong><br>Informacja dla klientów</strong></h3>
<p>Po zakończeniu naprawy pojazdu klient zostanie powiadomiony SMS-em o&nbsp;gotowości auta do&nbsp;odbioru.</p>
<p>W przypadku, gdy klient&nbsp;<strong>nie odbierze pojazdu w&nbsp;ciągu 2 dni od&nbsp;wysłania SMS-a,</strong> automatycznie zostanie naliczona opłata za&nbsp;przechowanie pojazdu w&nbsp;wysokości <strong>30&nbsp;zł za&nbsp;każdą rozpoczętą dobę.</strong></p>
<p>Prosimy o&nbsp;terminowy odbiór pojazdu, aby uniknąć dodatkowych kosztów.<br><br></p>
<hr>
<p>&nbsp;</p>
</div></div>
<div class="row"><div class="col-md-12">
<p>&nbsp;</p>
<h2><strong>Ważna informacja dla klientów</strong></h2>
<p>W przypadku, gdy przyjeżdżają Państwo na&nbsp;usługę lub&nbsp;naprawę z&nbsp;własnymi częściami, do&nbsp;ceny wykonanej usługi zostanie doliczona opłata w&nbsp;wysokości <strong>20% wartości robocizny.</strong></p>
<p>Informujemy również, że na&nbsp;części dostarczone przez klienta <strong>nie udzielamy gwarancji.</strong></p>
<p>Dziękujemy za&nbsp;zrozumienie!<br><br></p>
<hr>
<p>&nbsp;</p>
</div></div>
<div class="row"><div class="col-md-8">
<h2>Opony 2025</h2>
<table class="table" style="width: 85.2257%; height: 795.797px;">
<tbody>
<tr style="height: 43.5469px;">
<th style="width: 47.5692%; height: 43.5469px;">Usługa</th>
<th style="width: 3.39673%; height: 43.5469px;">Cena</th>
<th style="width: 9.64654%; height: 43.5469px;">&nbsp;</th>
<th style="width: 17.6853%; height: 43.5469px;">&nbsp;</th>
<th style="width: 21.8655%; height: 43.5469px;">&nbsp;</th>
</tr>
<tr style="height: 43.5469px;">
<td style="width: 47.5692%; height: 43.5469px;">Naprawa opony łatka</td>
<td style="width: 3.39673%; height: 43.5469px;">80 zł</td>
<td style="width: 9.64654%; height: 43.5469px;">&nbsp;</td>
<td style="width: 17.6853%; height: 43.5469px;">&nbsp;</td>
<td style="width: 21.8655%; height: 43.5469px;">&nbsp;</td>
</tr>
<tr style="height: 43.5469px;">
<td style="width: 47.5692%; height: 43.5469px;">Naprawa opony sznurek</td>
<td style="width: 3.39673%; height: 43.5469px;">40 zł</td>
<td style="width: 9.64654%; height: 43.5469px;">&nbsp;</td>
<td style="width: 17.6853%; height: 43.5469px;">&nbsp;</td>
<td style="width: 21.8655%; height: 43.5469px;">&nbsp;</td>
</tr>
<tr style="height: 69.0469px;">
<td style="width: 47.5692%; height: 69.0469px; text-align: left;"><strong>Wymiana opon stal+wyważenie do</strong></td>
<td style="width: 3.39673%; height: 69.0469px;">do R16</td>
<td style="width: 9.64654%; height: 69.0469px;">160 zł</td>
<td style="width: 17.6853%; height: 69.0469px;">Czujniki + 20 zł</td>
<td style="width: 21.8655%; height: 69.0469px;">Bus + 20%</td>
</tr>
<tr style="height: 69.0469px;">
<td style="width: 47.5692%; height: 69.0469px;">&nbsp;</td>
<td style="width: 3.39673%; height: 69.0469px;">do R17</td>
<td style="width: 9.64654%; height: 69.0469px;">180 zł</td>
<td style="width: 17.6853%; height: 69.0469px;">Czujniki + 20 zł</td>
<td style="width: 21.8655%; height: 69.0469px;">Bus + 20%</td>
</tr>
<tr style="height: 69.0469px;">
<td style="width: 47.5692%; height: 69.0469px; text-align: left;"><strong>Wymiana opon alusy+wyważenie do</strong></td>
<td style="width: 3.39673%; height: 69.0469px;">do R16</td>
<td style="width: 9.64654%; height: 69.0469px;">180 zł</td>
<td style="width: 17.6853%; height: 69.0469px;">Czujniki + 20 zł</td>
<td style="width: 21.8655%; height: 69.0469px;">Bus + 20%</td>
</tr>
<tr style="height: 69.0469px;">
<td style="width: 47.5692%; height: 69.0469px;">&nbsp;</td>
<td style="width: 3.39673%; height: 69.0469px;">od R17</td>
<td style="width: 9.64654%; height: 69.0469px;">200 zł</td>
<td style="width: 17.6853%; height: 69.0469px;">Czujniki + 20 zł</td>
<td style="width: 21.8655%; height: 69.0469px;">Bus + 20%</td>
</tr>
<tr>
<td style="width: 47.5692%;">&nbsp;</td>
<td style="width: 3.39673%;">od R19</td>
<td style="width: 9.64654%;">230 zł</td>
<td style="width: 17.6853%;">Czujniki + 20 zł</td>
<td style="width: 21.8655%;">Bus + 20%</td>
</tr>
<tr style="height: 43.5469px;">
<td style="width: 47.5692%; height: 43.5469px;">Wyważenie</td>
<td style="width: 3.39673%; height: 43.5469px;">35 zł/szt.</td>
<td style="width: 9.64654%; height: 43.5469px;">&nbsp;</td>
<td style="width: 17.6853%; height: 43.5469px;">&nbsp;</td>
<td style="width: 21.8655%; height: 43.5469px;">&nbsp;</td>
</tr>
<tr style="height: 120.047px;">
<td style="width: 47.5692%; height: 120.047px;">Wyważenie bez&nbsp;montażu felgi stalowe/felgi aluminiowe</td>
<td style="width: 3.39673%; height: 120.047px;">zadzwoń i&nbsp;zapytaj o&nbsp;szczegóły *</td>
<td style="width: 9.64654%; height: 120.047px;">&nbsp;</td>
<td style="width: 17.6853%; height: 120.047px;">&nbsp;</td>
<td style="width: 21.8655%; height: 120.047px;">&nbsp;</td>
</tr>
<tr style="height: 43.5469px;">
<td style="width: 47.5692%; height: 43.5469px;">Przechowywanie opon i&nbsp;felg przez cały sezon&nbsp;</td>
<td style="width: 3.39673%; height: 43.5469px;">120 zł/kpl.</td>
<td style="width: 9.64654%; height: 43.5469px;">&nbsp;</td>
<td style="width: 17.6853%; height: 43.5469px;">&nbsp;</td>
<td style="width: 21.8655%; height: 43.5469px;">&nbsp;</td>
</tr>
<tr style="height: 43.5469px;">
<td style="width: 47.5692%; height: 43.5469px;">Pozostawienie opon do&nbsp;utylizacji – komplet</td>
<td style="width: 3.39673%; height: 43.5469px;">15 zł/szt</td>
<td style="width: 9.64654%; height: 43.5469px;">&nbsp;</td>
<td style="width: 17.6853%; height: 43.5469px;">&nbsp;</td>
<td style="width: 21.8655%; height: 43.5469px;">&nbsp;</td>
</tr>
<tr style="height: 94.7344px;">
<td style="width: 47.5692%; height: 94.7344px;">Worki na&nbsp;opony</td>
<td style="width: 3.39673%; height: 94.7344px;">4 zł/szt. (zakup 1,5 zł)</td>
<td style="width: 9.64654%; height: 94.7344px;">&nbsp;</td>
<td style="width: 17.6853%; height: 94.7344px;">&nbsp;</td>
<td style="width: 21.8655%; height: 94.7344px;">&nbsp;</td>
</tr>
</tbody>
</table>
<p>* zadzwoń pod&nbsp;numer telefonu i&nbsp;dowiedz&nbsp;się więcej&nbsp;</p>
</div></div>
<div class="row" disabled=""></div>
<div class="row" disabled=""><div class="col-md-12" disabled=""><hr class="hr-extrakgkkh3hh" disabled=""></div></div>
<div class="row" disabled=""><div class="col-md-12" disabled=""><hr class="hr-extrakgkkh3hh" disabled=""></div></div>
<div class="row">
<div class="col-md-5">
<h2>Olej 2025</h2>
<table class="table" style="width: 100%; height: 194.4px;">
<tbody>
<tr>
<th style="width: 49.9242%;">Usługa</th>
<th style="width: 15.1668%;">Zastosowanie</th>
<th style="width: 11.6214%; text-align: center;">Cena</th>
<th style="width: 23.2623%;">&nbsp;</th>
</tr>
<tr>
<td style="width: 49.9242%;"><strong>&nbsp;</strong></td>
<td style="width: 15.1668%;">Olej + filtr oleju</td>
<td style="width: 11.6214%; text-align: center;">150 zł</td>
<td style="width: 23.2623%;">&nbsp;</td>
</tr>
<tr style="height: 64.8px;">
<td style="width: 49.9242%; height: 64.8px;"><strong>Wymiana oleju silnika</strong></td>
<td style="width: 15.1668%; height: 64.8px;">Olej + wszyst. filtry</td>
<td style="width: 11.6214%; text-align: center; height: 64.8px;">200 zł</td>
<td style="width: 23.2623%; height: 64.8px;">benzyna</td>
</tr>
<tr style="height: 64.8px;">
<td style="width: 49.9242%; height: 64.8px;">&nbsp;</td>
<td style="width: 15.1668%; height: 64.8px;">Olej + wszyst. filtry</td>
<td style="width: 11.6214%; text-align: center; height: 64.8px;">250 zł</td>
<td style="width: 23.2623%; height: 64.8px;">diesel</td>
</tr>
</tbody>
</table>
<h2>&nbsp;</h2>
<table class="table">
<tbody>
<tr>
<th>Usługa</th>
<th>Cena</th>
</tr>
<tr>
<td>Wymiana oleju skrzynia manual</td>
<td>od 120 zł</td>
</tr>
<tr>
<td>Wymiana oleju skrzynia automat (stat.)</td>
<td>od 180 zł</td>
</tr>
<tr>
<td>Wymiana płynu hamulcowego</td>
<td>200 zł</td>
</tr>
<tr>
<td>Wymiana płynu chłodniczego</td>
<td>150 zł</td>
</tr>
<tr>
<td>Roboczogodzina</td>
<td>180 zł</td>
</tr>
<tr>
<td>Roboczogodzina (samochody osobowo-dostawcze, dostawcze)</td>
<td>200 zł</td>
</tr>
</tbody>
</table>
<h2>&nbsp;</h2>
<h2>Konserwacja</h2>
<table class="table" style="width: 100%; height: 194.4px;">
<tbody>
<tr>
<th style="width: 88.7671%;">Usługa</th>
<th style="width: 11.2329%;">Cena</th>
</tr>
<tr>
<td style="width: 88.7671%; height: 63.8px;">Wycena konserwacji (w przypadku, gdy klient nie&nbsp;będzie robić u&nbsp;nas)</td>
<td style="width: 11.2329%; height: 63.8px;">100 zł</td>
</tr>
<tr style="height: 64.8px;">
<td style="width: 88.7671%; height: 64.8px;">Konserwacja podstawowa</td>
<td style="width: 11.2329%; height: 64.8px;">od 1000 zł</td>
</tr>
<tr style="height: 64.8px;">
<td style="width: 88.7671%; height: 64.8px;">Konserwacja pełna</td>
<td style="width: 11.2329%; height: 64.8px;">od 2000 zł</td>
</tr>
</tbody>
</table>
</div>
<div class="col-md-5 col-md-offset-2">
<h2>Układ hamulcowy</h2>
<table class="table">
<tbody>
<tr>
<th>Usługa</th>
<th>Cena</th>
</tr>
<tr>
<td>Wymiana klocków hamulcowych 1 oś</td>
<td>od 170 zł</td>
</tr>
<tr>
<td>Wymiana tarcz i&nbsp;klocków 1 oś</td>
<td>od 250 zł</td>
</tr>
<tr>
<td>Wymiana płynu hamulcowego</td>
<td>od 200 zł</td>
</tr>
<tr>
<td>Wymiana linki ręcznego</td>
<td>od 270 zł</td>
</tr>
<tr>
<td>Wymiana zacisku tył</td>
<td>od 180 zł</td>
</tr>
<tr>
<td>Wymiana zacisku przód</td>
<td>od 200 zł</td>
</tr>
<tr>
<td>Konserwacja zacisku</td>
<td>od 350 zł</td>
</tr>
<tr>
<td>Wymiana pompy ABS</td>
<td>od 400 zł</td>
</tr>
<tr>
<td>Wymiana przewodu elastycznego</td>
<td>od 80 zł</td>
</tr>
<tr>
<td>Wymiana przewodu miedziany</td>
<td>od 150 zł</td>
</tr>
<tr>
<td>Wymiana szczęk hamulcowych</td>
<td>od 100&nbsp;zł</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class="row" disabled=""><div class="col-md-12" disabled=""><hr class="hr-extrakgkkh3hh" disabled=""></div></div>
<div class="row">
<div class="col-md-5">
<h2>Zawieszenie</h2>
<table class="table" style="width: 100%; height: 816px;">
<tbody>
<tr style="height: 40.8px;">
<th style="width: 67.6947%; height: 40.8px;">Usługa</th>
<th style="width: 32.196%; height: 40.8px;">Cena</th>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Geometria</td>
<td style="width: 32.196%; height: 40.8px;">200/300 (z osi)</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px; text-align: left;"><strong>Wymiana</strong></td>
<td style="width: 32.196%; height: 40.8px;">&nbsp;</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">półoś (simering)</td>
<td style="width: 32.196%; height: 40.8px;">od 300 do&nbsp;500 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">przegub (osłona)</td>
<td style="width: 32.196%; height: 40.8px;">od 250 do&nbsp;450 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana amortyzatora oś tylna</td>
<td style="width: 32.196%; height: 40.8px;">od 150&nbsp;zł do&nbsp;350 (1 szt.)</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana amortyzatora przód - sprężyny, poduszki</td>
<td style="width: 32.196%; height: 40.8px;">od 250 do&nbsp;400 (1 szt.)</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana łożyska koła przód</td>
<td style="width: 32.196%; height: 40.8px;">od 300 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana łożyska koła tył</td>
<td style="width: 32.196%; height: 40.8px;">od 250 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana łożyska ze zwrotnicą</td>
<td style="width: 32.196%; height: 40.8px;">od 150 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana końcówki drążka kierowniczego</td>
<td style="width: 32.196%; height: 40.8px;">od 120 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana drążka kierowniczego</td>
<td style="width: 32.196%; height: 40.8px;">od 150 zł/szt.</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana sworznia wahacza</td>
<td style="width: 32.196%; height: 40.8px;">od 150 zł/szt.</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana tulei wahacza 1 szt</td>
<td style="width: 32.196%; height: 40.8px;">&nbsp;od&nbsp;300 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana wahacza</td>
<td style="width: 32.196%; height: 40.8px;">&nbsp;od&nbsp;200 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana łączników stabilizatora (guma stabilizatora)</td>
<td style="width: 32.196%; height: 40.8px;">&nbsp;od&nbsp;120 zł/szt.</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana przekładni kierowniczej (maglownicy)</td>
<td style="width: 32.196%; height: 40.8px;">&nbsp;od&nbsp;300 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana belki oś tylna</td>
<td style="width: 32.196%; height: 40.8px;">&nbsp;od&nbsp;750 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana poduszki silnika</td>
<td style="width: 32.196%; height: 40.8px;">od 150 do&nbsp;550 zł</td>
</tr>
<tr>
<td style="width: 67.6947%;">Wymiana tuleji belki (cukierka)</td>
<td style="width: 32.196%;">od 150 do&nbsp;350 zł</td>
</tr>
<tr>
<td style="width: 67.6947%;">Wymiana poduszki belki</td>
<td style="width: 32.196%;">od 150 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 67.6947%; height: 40.8px;">Wymiana tłumika środkowego lub&nbsp;końcówki</td>
<td style="width: 32.196%; height: 40.8px;">&nbsp;od&nbsp;200 zł</td>
</tr>
</tbody>
</table>
</div>
<div class="col-md-5 col-md-offset-2">
<h2>Silnik i&nbsp;skrzynia</h2>
<table class="table" style="width: 100%; height: 1077.8px;">
<tbody>
<tr style="height: 40.8px;">
<th style="width: 73.5947%; height: 40.8px;">Usługa</th>
<th style="width: 26.2962%; height: 40.8px;">Cena</th>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana sprzęgła</td>
<td style="width: 26.2962%; height: 40.8px;">od 1080 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana paska napędu osprzętu</td>
<td style="width: 26.2962%; height: 40.8px;">od 120 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana rozrządu (pasek)</td>
<td style="width: 26.2962%; height: 40.8px;">od 1250 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana rozrządu (łańcuch)</td>
<td style="width: 26.2962%; height: 40.8px;">od 1450 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana sondy</td>
<td style="width: 26.2962%; height: 40.8px;">od 150 do&nbsp;400 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana pasku napędu</td>
<td style="width: 26.2962%; height: 40.8px;">od 120 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana uszczelki pokrywy zaworów</td>
<td style="width: 26.2962%; height: 40.8px;">od 250 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana uszczelki głowicy</td>
<td style="width: 26.2962%; height: 40.8px;">od 1500 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana uszczelki miski</td>
<td style="width: 26.2962%; height: 40.8px;">od 250 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana świec zapłonowych</td>
<td style="width: 26.2962%; height: 40.8px;">&nbsp;od&nbsp;30 zł/szt.</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana świec żarowych</td>
<td style="width: 26.2962%; height: 40.8px;">&nbsp;od&nbsp;50 zł/szt.</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana wtryskiwacza diesel</td>
<td style="width: 26.2962%; height: 40.8px;">&nbsp;od&nbsp;60 zł/szt.</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana wtryskiwacza diesel + kodowanie</td>
<td style="width: 26.2962%; height: 40.8px;">od 100 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana wtrysku benzyna</td>
<td style="width: 26.2962%; height: 40.8px;">od 120 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana alternatora/rozrusznika</td>
<td style="width: 26.2962%; height: 40.8px;">od 250 zł</td>
</tr>
<tr style="height: 45.8px;">
<td style="width: 73.5947%; height: 45.8px;">Wymiana pompy wspomagania</td>
<td style="width: 26.2962%; height: 45.8px;">od 400 zł</td>
</tr>
<tr style="height: 50.8px;">
<td style="width: 73.5947%; height: 50.8px;">Wymiana chłodnicy wody</td>
<td style="width: 26.2962%; height: 50.8px;">od 400 zł</td>
</tr>
<tr style="height: 42.8px;">
<td style="width: 73.5947%; height: 42.8px;">Wymiana turbo</td>
<td style="width: 26.2962%; height: 42.8px;">od 550 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana pompy paliwa (w zbiorn.)</td>
<td style="width: 26.2962%; height: 40.8px;">&nbsp;od&nbsp;200 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana pompy paliwa wysokiego ciśnienia</td>
<td style="width: 26.2962%; height: 40.8px;">&nbsp;od&nbsp;500 zł</td>
</tr>
<tr style="height: 40.8px;">
<td style="width: 73.5947%; height: 40.8px;">Wymiana linki sprzęgła</td>
<td style="width: 26.2962%; height: 40.8px;">&nbsp;od&nbsp;250 zł</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class="row" disabled=""><div class="col-md-12" disabled=""><hr class="hr-extrakgkkh3hh" disabled=""></div></div>
<div class="row">
<div class="col-md-5">
<h2>Diagnostyka samochodowa</h2>
<table class="table" style="width: 99.9732%; height: 163.2px;">
<tbody>
<tr style="height: 40.8px;">
<th style="width: 87.8447%; height: 40.8px;"><span style="font-weight: 400;">Usługa</span></th>
<th style="width: 12.075%; height: 40.8px;"><span style="font-weight: 400;">Cena</span></th>
</tr>
<tr style="height: 40.8px;">
<td style="width: 87.8447%; height: 40.8px;">Diagnostyka komputerowa &nbsp;(kasowanie, odczyt błędów) &nbsp; &nbsp;</td>
<td style="width: 12.075%; height: 40.8px;">150 zł</td>
</tr>
<tr>
<td style="width: 87.8447%;">Przegląd techniczny</td>
<td style="width: 12.075%;">220 zł</td>
</tr>
<tr>
<td style="width: 87.8447%;">Diagnostyka zawieszenia</td>
<td style="width: 12.075%;">od 150 zł</td>
</tr>
<tr>
<td style="width: 87.8447%;">Diagnostyka przed zakupem auta (+komputer)</td>
<td style="width: 12.075%;">500 zł</td>
</tr>
</tbody>
</table>
</div>
<div class="col-md-5 col-md-offset-2">
<h2>Pełny serwis klimatyzacji z&nbsp;odgrzybianiem (ozonowanie)</h2>
<table class="table">
<tbody>
<tr>
<th>Usługa</th>
<th>Cena</th>
</tr>
<tr>
<td>Usługa</td>
<td>155 zł</td>
</tr>
<tr>
<td>100&nbsp;g czynnika chłodniczego R134a</td>
<td>40zł</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class="row" disabled=""><div class="col-md-12" disabled=""><hr class="hr-extrakgkkh3hh" disabled=""></div></div>
<div class="row"><div class="col-md-12">
<h2>WARUNKI GWARANCJI USŁUG SERWISOWYCH</h2>
<p>Dbając o&nbsp;przejrzystość zasad oraz&nbsp;komfort naszych Klientów, poniżej przedstawiamy warunki gwarancji na&nbsp;usługi wykonywane w&nbsp;naszym serwisie.</p>
<p><strong>1. Zakres i&nbsp;czas trwania gwarancji</strong></p>
<p>Serwis udziela gwarancji na&nbsp;wykonaną usługę na&nbsp;okres 5 miesięcy lub&nbsp;5 000 km, w&nbsp;zależności od&nbsp;tego, co nastąpi wcześniej.<br>Gwarancja obejmuje prawidłowość wykonania usługi zgodnie z&nbsp;zasadami sztuki serwisowej.</p>
<p><br><strong>2. Gwarancja na&nbsp;części zamienne</strong></p>
<p>Gwarancja na&nbsp;części zamienne udzielana jest przez producenta lub&nbsp;dostawcę części, zgodnie z&nbsp;jego&nbsp;indywidualnymi warunkami gwarancyjnymi.<br>Serwis nie&nbsp;jest producentem części i&nbsp;nie&nbsp;decyduje o&nbsp;uznaniu lub&nbsp;odrzuceniu reklamacji części przez producenta.<br><br></p>
<p><strong>3. Procedura reklamacyjna</strong></p>
<p>Każda reklamacja wymaga:</p>
<ul>
<li>wcześniejszego zgłoszenia w&nbsp;serwisie,</li>
<li>przeprowadzenia ponownej diagnostyki pojazdu w&nbsp;celu ustalenia przyczyny usterki.</li>
</ul>
<p>Zgłoszenie reklamacji nie&nbsp;oznacza jej&nbsp;automatycznego uznania.<br><br></p>
<p><strong>4. Podejrzenie wady fabrycznej części</strong></p>
<p>W przypadku podejrzenia wady fabrycznej części:</p>
<ul>
<li>koszt demontażu reklamowanej części,</li>
<li>koszt montażu części zamiennej,</li>
<li>koszt nowej części ponosi Klient do&nbsp;momentu otrzymania oficjalnej decyzji producenta lub&nbsp;dostawcy części.</li>
</ul>
<p>&nbsp;</p>
<p><strong>5. Decyzja producenta</strong></p>
<p>W przypadku uznania reklamacji przez producenta lub&nbsp;dostawcę części:</p>
<p>Klient otrzymuje zwrot kosztów lub&nbsp;wymianę części zgodnie z&nbsp;warunkami gwarancji producenta,<br>koszty robocizny podlegają zwrotowi wyłącznie wtedy, gdy producent wyraźnie je obejmuje.</p>
<p>W przypadku nieuznania reklamacji przez producenta lub&nbsp;dostawcę części, wszystkie poniesione koszty pozostają po&nbsp;stronie Klienta.<br><br></p>
<p><strong>6. Wyłączenia gwarancji</strong></p>
<p>Gwarancja nie&nbsp;obejmuje:</p>
<ul>
<li>naturalnego zużycia eksploatacyjnego części,</li>
<li>uszkodzeń powstałych w&nbsp;wyniku dalszej jazdy mimo występowania usterki,</li>
<li>uszkodzeń wynikających z&nbsp;niewłaściwej eksploatacji pojazdu,</li>
<li>ingerencji osób trzecich lub&nbsp;innych serwisów,</li>
<li>usterek niezwiązanych bezpośrednio z&nbsp;wcześniej wykonaną usługą.</li>
</ul>
<p>&nbsp;</p>
<p><strong>7. Postanowienia końcowe</strong></p>
<p>Niniejsze warunki gwarancji nie&nbsp;wyłączają ani&nbsp;nie&nbsp;ograniczają uprawnień konsumenta wynikających z&nbsp;obowiązujących przepisów prawa, w&nbsp;szczególności z&nbsp;tytułu rękojmi.</p>
<p>&nbsp;</p>
<hr>
<p>&nbsp;</p>
</div></div>',0,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('kontakt','page','Kontakt','Dane kontaktowe autoserwisu Soft Car Service w Czechowicach-Dziedzicach','Kontakt z Soft Car Service w Czechowicach-Dziedzicach','W przypadku pytań dotyczących oferty, serdecznie zapraszamy do kontaktu z naszą firmą. Wszystkie niezbędne dane kontaktowe znajdują się na stronie internetowej.','/images/design/banner.webp','<div class="row"><div class="col-md-12"><h1>Dane kontaktowe autoserwisu Soft Car Service w&nbsp;Czechowicach-Dziedzicach</h1></div></div>
<div class="row"><div class="col-md-12"><p><span>Jesteśmy tu&nbsp;dla Ciebie, aby pomóc Ci&nbsp;utrzymać samochód w&nbsp;doskonałym stanie. Skontaktuj&nbsp;się z&nbsp;nami, aby dowiedzieć&nbsp;się więcej o&nbsp;naszych usługach lub&nbsp;umówić&nbsp;się na&nbsp;wizytę. Nasz&nbsp;zespół specjalistów jest zawsze gotowy, aby odpowiedzieć na&nbsp;pytania i&nbsp;dostarczyć Ci&nbsp;najwyższej jakości usługi. Zapraszamy również do&nbsp;odwiedzenia naszego serwisu przy ul. Legionów 124, Czechowice-Dziedzice. Czekamy na&nbsp;Ciebie!</span></p></div></div>',0,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('polityka-prywatnosci','legal','Polityka prywatności','POLITYKA PRYWATNOŚCI SERWISUwww.softcarservice.pl','Polityka prywatności',null,'/images/design/banner.webp','<div class="row"><div class="col-md-12" id="boxx">
<h1 style="text-align: left;">POLITYKA PRYWATNOŚCI SERWISU<br><strong>www.softcarservice.pl</strong>
</h1>
<p style="text-align: justify;">Ochrona prywatności Użytkowników jest dla <strong>KROPLA ZDROWIA SPÓŁKA Z&nbsp;OGRANICZONĄ ODPOWIEDZIALNOŚCIĄ</strong> szczególnie ważna. Z&nbsp;tego względu Użytkownicy Serwisu <strong>www.softcarservice.pl</strong> mają zagwarantowane wysokie standardy ochrony prywatności. <strong>KROPLA ZDROWIA SPÓŁKA Z&nbsp;OGRANICZONĄ ODPOWIEDZIALNOŚCIĄ</strong> jako Administrator danych dba o&nbsp;bezpieczeństwo udostępnionych przez Użytkowników danych.</p>
<p style="text-align: justify;">Celem Administratora jest również należyte informowanie Użytkowników o&nbsp;prawach i&nbsp;obowiązkach związanych z&nbsp;przetwarzaniem danych osobowych, szczególnie wobec treści przepisów o&nbsp;ochronie danych osobowych określonych w&nbsp;rozporządzeniu Parlamentu Europejskiego i&nbsp;Rady (UE) 2016/679 z&nbsp;dnia 27.04.2016r. w&nbsp;sprawie ochrony osób fizycznych w&nbsp;związku z&nbsp;przetwarzaniem danych osobowych i&nbsp;w&nbsp;sprawie swobodnego przepływu takich danych oraz&nbsp;uchylenia dyrektywy 95/46/WE (dalej jako „RODO”). Dlatego też, dbając o&nbsp;ochronę prywatności Użytkowników Serwisu, w&nbsp;niniejszym dokumencie Administrator informuje o&nbsp;podstawach prawnych przetwarzania danych osobowych przekazanych przez Użytkowników w&nbsp;związku z&nbsp;korzystaniem przez nich z&nbsp;Serwisu <strong>www.softcarservice.pl</strong> <em>(dalej jako „Serwis”)</em>, sposobach zbierania, przetwarzania i&nbsp;ochrony danych osobowych, a&nbsp;także o&nbsp;prawach Użytkowników.</p>
<p style="text-align: justify;">Użytkownikiem jest każda osoba fizyczna, której dane dotyczą, korzystająca z&nbsp;serwisu internetowego <strong>www.softcarservice.pl</strong> lub&nbsp;usług elektronicznych dostępnych za&nbsp;pośrednictwem Serwisu.</p>
<p style="text-align: justify;">Administratorem danych osobowych udostępnionych przez Użytkownika w&nbsp;Serwisie <strong>www.softcarservice.pl</strong> jest <strong>KROPLA ZDROWIA SPÓŁKA Z&nbsp;OGRANICZONĄ ODPOWIEDZIALNOŚCIĄ, ul. Strażacka 81, 43-382 Bielsko-Biała, NIP 5472234073, </strong> <em>(dalej jako „Administrator”)</em>.</p>
<p style="text-align: justify;">&nbsp;</p>
<ol style="list-style-type: upper-roman; text-align: justify;">
<li>
<strong>ZGODA UŻYTKOWNIKA</strong><br>
<p>Korzystanie z&nbsp;Serwisu <strong>www.softcarservice.pl</strong> przez Użytkownika oznacza, że Użytkownik akceptuje, że Administrator gromadzi oraz&nbsp;wykorzystuje dane osobowe zgodnie z&nbsp;niniejszą Polityką Prywatności.</p>
<p>Dane osobowe Użytkownika Serwisu są przetwarzane przez Administratora w&nbsp;oparciu o&nbsp;jego&nbsp;zgodę, zaś&nbsp;w&nbsp;niektórych przypadkach opisanych w&nbsp;niniejszym dokumencie, w&nbsp;ramach prawnie uzasadnionego interesu Administratora. Użytkownik ma prawo w&nbsp;dowolnym momencie wycofać wyrażoną wcześniej zgodę. Wycofanie zgody nie&nbsp;wpływa na&nbsp;zgodność z&nbsp;prawem przetwarzania, którego dokonano na&nbsp;podstawie zgody przed jej&nbsp;wycofaniem.</p>
<p>W przypadku, gdy nastąpi zmiana niniejszej Polityki Prywatności, a&nbsp;Użytkownik nadal będzie korzystał z&nbsp;Serwisu, to&nbsp;poczytuje&nbsp;się to&nbsp;za&nbsp;wyrażenie zgody na&nbsp;aktualne warunki Polityki Prywatności.</p>
</li>
<li>
<strong>DANE OSOBOWE PRZETWARZANE PRZEZ ADMINISTRATORA</strong>
<ol style="list-style-type: decimal;">
<li>
<strong>Sposób pozyskiwania danych osobowych</strong>
<p>Administrator pozyskuje dane osobowe bezpośrednio od&nbsp;Użytkownika za&nbsp;pośrednictwem Serwisu, poprzez&nbsp;dostępne w&nbsp;nim funkcjonalności i&nbsp;narzędzia do&nbsp;komunikacji oraz&nbsp;przesłanie za&nbsp;ich&nbsp;pośrednictwem wiadomości do&nbsp;Administratora.</p>
<p>Podanie danych osobowych przez Użytkownika jest dobrowolne.</p>
</li>
<li>
<strong>Rodzaje przetwarzanych danych osobowych</strong>
<p>Administrator gromadzi za&nbsp;pośrednictwem Serwisu następujące dane osobowe dotyczące Użytkownika:</p>
<ol style="list-style-type: decimal;">
<li>Imię i&nbsp;nazwisko;</li>
<li>Adres e-mail;</li>
<li>Numer telefonu;</li>
<li>Treść wiadomości;</li>
<li>Temat wiadomości.</li>
</ol>
</li>
</ol>
<p>&nbsp;</p>
</li>
<li>
<strong>CELE PRZETWARZANIA DANYCH OSOBOWYCH</strong>
<p>Sposób przetwarzania przez Administratora danych dotyczących Użytkownika zależy od&nbsp;sposobu korzystania przez Użytkownika z&nbsp;Serwisu i&nbsp;dostępnych w&nbsp;nim funkcjonalności. Administrator przetwarza dane osobowe Użytkownika w&nbsp;następujących celach:</p>
<ol style="list-style-type: decimal;">
<li>
<strong>Komunikacji z&nbsp;Użytkownikiem.</strong>
<p>Administrator wykorzystuje dane osobowe Użytkownika w&nbsp;celu komunikacji z&nbsp;nim w&nbsp;spersonalizowany sposób. Komunikowane Użytkownikowi informacje dotyczą oferowanych produktów lub&nbsp;usług, bezpieczeństwa danych osobowych, aktualizacji sieci, przypomnień, ale&nbsp;również sugerowanych ofert Administratora lub&nbsp;jego&nbsp;partnerów. Komunikacja z&nbsp;Użytkownikiem dotyczy także obsługi Użytkownika. Dane osobowe wykorzystywane są w&nbsp;celu pomocy Użytkownikowi, rozwiązaniu problemów technicznych oraz&nbsp;odpowiedzi na&nbsp;jego&nbsp;skargi lub&nbsp;reklamacje.</p>
</li>
<li>
<strong>Przedstawiania Użytkownikowi ofert handlowych drogą elektroniczną.</strong>
<p>Celem korzystania z&nbsp;danych osobowych Użytkownika udostępnionych przez niego za&nbsp;pośrednictwem funkcjonalności i&nbsp;narzędzi do&nbsp;komunikacji dostępnych w&nbsp;Serwisie jest komunikacja marketingowa prowadzona przez Administratora w&nbsp;ramach prowadzonej działalności, w&nbsp;szczególności przedstawianie ofert handlowych Użytkownikowi drogą elektroniczną.</p>
</li>
<li>
<strong>Przedstawiania Użytkownikowi ofert handlowych w&nbsp;kontakcie telefonicznym.</strong>
<p>Celem korzystania z&nbsp;danych osobowych Użytkownika udostępnionych przez niego za&nbsp;pośrednictwem funkcjonalności i&nbsp;narzędzi do&nbsp;komunikacji dostępnych w&nbsp;Serwisie jest komunikacja marketingowa prowadzona przez Administratora w&nbsp;ramach prowadzonej działalności, w&nbsp;szczególności poprzez&nbsp;przedstawianie ofert handlowych Użytkownikowi w&nbsp;kontakcie telefonicznym.</p>
</li>
<li>
<strong>Przesyłania Użytkownikowi informacji drogą elektroniczną w&nbsp;ramach zapisu na&nbsp;newsletter Administratora.</strong>
<p>Celem korzystania przez Administratora z&nbsp;danych osobowych Użytkownika udostępnionych w&nbsp;ramach formularza zapisu na&nbsp;newsletter Administratora udostępnionego w&nbsp;Serwisie jest informowanie Użytkownika drogą elektroniczną (e-mailowo) o&nbsp;nowych produktach, usługach, promocjach lub&nbsp;wydarzeniach Administratora lub&nbsp;jego&nbsp;partnerów.</p>
</li>
<li>
<strong>Umożliwienia przesyłania przez Użytkownika komentarzy lub&nbsp;opinii.</strong>
<p>Administrator wykorzystuje dane osobowe Użytkownika w&nbsp;celu umożliwienia mu komentowania/opiniowania działalności, usług lub&nbsp;produktów Administratora lub&nbsp;podmiotów z&nbsp;nim współpracujących.</p>
</li>
</ol>
<p>Administrator może przetwarzać dane osobowe Użytkownika pozyskane za&nbsp;pośrednictwem Serwisu również w&nbsp;następujących celach:</p>
<ol style="list-style-type: decimal;">
<li>w celu zawarcia i&nbsp;realizacji ewentualnej umowy pomiędzy Użytkownikiem a&nbsp;Administratorem oraz&nbsp;obsługi Użytkownika jako klienta Administratora zgodnie z&nbsp;art. 6 ust. 1 lit. b) RODO;</li>
<li>w celu prowadzenia rozliczeń finansowych z&nbsp;Użytkownikiem będącym klientem Administratora tytułem realizacji ewentualnej umowy zawartej między stronami, a&nbsp;także ewentualnego dochodzenia roszczeń od&nbsp;Użytkownika będącego klientem w&nbsp;ramach prawnie uzasadnionego interesu Administratora zgodnie z&nbsp;art. 6 ust. 1 lit. f) RODO oraz&nbsp;spełnienia obowiązków prawnych Administratora wobec organów podatkowych na&nbsp;podstawie odrębnych przepisów zgodnie z&nbsp;art. 6 ust. 1 lit. c) RODO;</li>
<li>w celu realizacji działań marketingowych Administratora w&nbsp;ramach prawnie uzasadnionego interesu Administratora w&nbsp;rozumieniu art. 6 ust. 1 lit. f) RODO, a&nbsp;także zgodnie z&nbsp;oświadczeniami woli dotyczącymi komunikacji marketingowej złożonymi wobec Administratora. Zgody udzielone w&nbsp;zakresie komunikacji marketingowej (np. na&nbsp;przesyłanie informacji handlowych drogą elektroniczną lub&nbsp;kontakt telefoniczny w&nbsp;celach marketingu bezpośredniego) mogą być wycofane w&nbsp;dowolnym czasie, bez&nbsp;wpływu na&nbsp;zgodność z&nbsp;prawem przetwarzania, którego dokonano na&nbsp;podstawie zgody przed jej&nbsp;cofnięciem;</li>
<li>w celu realizacji obowiązków prawnych Administratora wobec Użytkownika określonych w&nbsp;RODO, w&nbsp;rozumieniu art. 6 ust. 1 lit. c) RODO.</li>
</ol>
<p>&nbsp;</p>
</li>
<li>
<strong>UDOSTĘPNIANIE DANYCH OSOBOWYCH</strong>
<p>Dane osobowe Użytkownika są lub&nbsp;mogą być przekazywane następującym kategoriom odbiorców:</p>
<ol style="list-style-type: decimal;">
<li>dostawcom usług reklamowych lub&nbsp;marketingowych,</li>
<li>zewnętrznym firmom sprzedażowym,</li>
</ol>
<p>&nbsp;</p>
</li>
<li>
<strong>PRAWA UŻYTKOWNIKA</strong>
<ol style="list-style-type: decimal;">
<li>
<strong>Prawa Użytkownika </strong>
<p>Użytkownik na&nbsp;każdym etapie przetwarzania jego&nbsp;danych zapewniony ma szereg uprawnień pozwalających mu uzyskać dostęp do&nbsp;swoich danych, weryfikację prawidłowości przetwarzania danych, ich&nbsp;korektę, jak również ma prawo zgłoszenia sprzeciwu wobec ich&nbsp;przetwarzania, może żądać usunięcia danych, ograniczenia przetwarzania lub&nbsp;przeniesienia danych.</p>
<p>W przypadku chęci skorzystania przez Użytkownika z&nbsp;przysługujących mu praw jako podmiotu danych osobowych, może on&nbsp;się skontaktować z&nbsp;Administratorem za&nbsp;pomocą następujących danych kontaktowych: <strong> KROPLA ZDROWIA SPÓŁKA Z&nbsp;OGRANICZONĄ ODPOWIEDZIALNOŚCIĄ, ul. Strażacka 81, 43-382 Bielsko-Biała, <a href="mailto:kroplazdrowiapl@gmail.com">kroplazdrowiapl@gmail.com</a>.</strong></p>
</li>
<li>
<strong>Prawo wniesienia skargi do&nbsp;organu nadzorczego</strong>
<p>Użytkownik, którego dane osobowe są przetwarzane przez Administratora ma prawo wnieść skargę do&nbsp;organu nadzoru właściwego w&nbsp;sprawach ochrony danych osobowych (Prezesa Urzędu Ochrony Danych Osobowych).</p>
</li>
</ol>
</li>
<li>
<strong>PLIKI COOKIES</strong>
<ol style="list-style-type: decimal;">
<ol style="list-style-type: decimal;">Administrator informuje, iż podczas korzystania z&nbsp;Serwisu w&nbsp;urządzeniu końcowym Użytkownika zapisywane są fragmenty kodu zwane „cookies”, które są plikami tekstowymi odpowiadającymi zapytaniom HTTP kierowanym do&nbsp;serwera Administratora. Pliki „cookies” są instalowane przez każdą przeglądarkę, z&nbsp;której Użytkownik odwiedza Serwis. Pliki „cookies” wykorzystywane są w&nbsp;Serwisie w&nbsp;celu:
<ol style="list-style-type: lower-alpha;">
<li>utrzymania technicznej poprawności i&nbsp;ciągłości sesji pomiędzy serwerem Serwisu a&nbsp;urządzeniem końcowym Użytkownika;</li>
<li>optymalizacji korzystania przez Użytkownika ze stron internetowych Serwisu i&nbsp;dostosowania sposobu ich&nbsp;wyświetlania na&nbsp;urządzeniu końcowym Użytkownika;</li>
<li>zapewnienia bezpieczeństwa korzystania z&nbsp;Serwisu;</li>
<li>zbierania statystyk odwiedzin stron Serwisu wspierających ulepszanie ich&nbsp;struktury i&nbsp;zawartości;</li>
<li>wyświetlania na&nbsp;urządzeniu końcowym Użytkownika treści dostosowanych do&nbsp;jego&nbsp;preferencji.</li>
</ol>
</ol>
</ol>
<p>&nbsp;</p>
<p>Szczegółowe informacje odnośnie stosowanych przez Administratora plików cookie oraz&nbsp;zarządzania nimi dostępne są w&nbsp;<a href="/polityka-cookies" target="_blank" rel="noopener noreferrer">Polityce Cookies</a>.</p>
<p>&nbsp;</p>
</li>
<li>
<strong>INNE WAŻNE INFORMACJE</strong>
<p>&nbsp;</p>
<ol style="list-style-type: decimal;">
<li>
<strong>Ochrona bezpieczeństwa danych osobowych</strong>
<p>Administrator wprowadza odpowiednie środki mające na&nbsp;celu zapewnienie bezpieczeństwa danych osobowych Użytkownika. Bezpieczne korzystanie z&nbsp;Serwisu zapewniają stosowane systemy oraz&nbsp;procedury chroniące przed dostępem oraz&nbsp;ujawnieniem danych osobom niepożądanym. Ponadto stosowane przez Administratora systemy oraz&nbsp;procesy są regularnie monitorowane w&nbsp;celu wykrycia ewentualnych zagrożeń. Pozyskane przez Administratora dane osobowe przechowywane są w&nbsp;systemach komputerowych, do&nbsp;których dostęp jest ściśle ograniczony.</p>
</li>
<li>
<strong>Przechowywanie danych osobowych</strong>
<p>Okres przechowywania danych osobowych Użytkowników uzależniony jest od&nbsp;celów przetwarzania przez Administratora danych.<br> Administrator przechowuje dane osobowe przez taki&nbsp;okres, jaki jest konieczny do&nbsp;osiągnięcia określonych celów, tj.:</p>
<ul>
<li>przez okres prowadzenia działalności gospodarczej przez Administratora.</li>
</ul>
<p>&nbsp;</p>
<p>W każdym z&nbsp;powyższych przypadków, po&nbsp;upływie niezbędnego okresu przetwarzania, dane mogą być przetwarzane tylko&nbsp;w&nbsp;celu dochodzenia roszczeń na&nbsp;tle łączących strony relacji do&nbsp;czasu ostatecznego rozstrzygnięcia tych roszczeń na&nbsp;drodze prawnej.</p>
</li>
<li>
<strong>Zmiany Polityki prywatności</strong>
<p>W celu uaktualnienia informacji zawartych w&nbsp;niniejszej Polityce prywatności oraz&nbsp;jej&nbsp;zgodności z&nbsp;obowiązującymi przepisami prawa, niniejsza Polityka prywatności może ulec zmianie. W&nbsp;przypadku zmiany treści Polityki prywatności, zmieniona zostanie data jej&nbsp;aktualizacji wskazana na&nbsp;końcu jej&nbsp;tekstu. W&nbsp;celu zasięgnięcia informacji o&nbsp;sposobie ochrony danych osobowych, Administrator rekomenduje Użytkownikom regularne zapoznawanie&nbsp;się z&nbsp;postanowieniami Polityki Prywatności.</p>
</li>
<li>
<strong>Informacje kontaktowe</strong>
<p>W celu uzyskania jakichkolwiek informacji dotyczących niniejszej Polityki Prywatności, Użytkownik może skontaktować&nbsp;się z&nbsp;Administratorem danych osobowych: <strong> KROPLA ZDROWIA SPÓŁKA Z&nbsp;OGRANICZONĄ ODPOWIEDZIALNOŚCIĄ, ul. Strażacka 81, 43-382 Bielsko-Biała, </strong> z&nbsp;wykorzystaniem następujących danych kontaktowych: <strong><a href="mailto:kroplazdrowiapl@gmail.com">kroplazdrowiapl@gmail.com</a>.</strong></p>
<p>Ponadto istnieje również możliwość kontaktu drogą pocztową pod&nbsp;adresem: <strong>ul. Strażacka 81, 43-382 Bielsko-Biała</strong>.</p>
<p>&nbsp;</p>
</li>
</ol>
</li>
</ol>
<p style="text-align: justify;">Ostatnia aktualizacja niniejszego dokumentu miała miejsce dnia 18.09.2023.</p>
</div></div>',0,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('polityka-cookies','legal','Polityka Cookies','POLITYKA COOKIES','Polityka Cookies',null,'/images/design/banner.webp','<div class="row"><div class="col-md-12" id="boxx">
<h1 style="text-align: left;">POLITYKA COOKIES</h1>
<p style="text-align: justify;">Korzystamy z&nbsp;plików cookies w&nbsp;celu poprawienia efektywności i&nbsp;zaproponowania Użytkownikowi coraz doskonalszych funkcjonalności serwisu internetowego <strong>www.softcarservice.pl</strong> (dalej jako Serwis) oraz&nbsp;bardziej dopasowanych do&nbsp;Użytkownika treści. W&nbsp;celu zapewnienia przejrzystości działań zostaje przyjęta niniejsza Polityka Cookies, która określa szczegółowe zasady korzystania przez Serwis internetowy z&nbsp;plików cookies.</p>
<p style="text-align: justify;">Dane za&nbsp;pomocą plików cookies gromadzone są przez <strong>KROPLA ZDROWIA SPÓŁKA Z&nbsp;OGRANICZONĄ ODPOWIEDZIALNOŚCIĄ</strong>, adres <strong>ul. Strażacka 81, 43-382</strong> <strong>Bielsko-Biała</strong>, numer NIP: <strong>5472234073</strong>, numer REGON: <strong>523526651</strong>. W&nbsp;przypadku stwierdzenia, że dane zawarte w&nbsp;plikach cookies są danymi osobowymi <strong>KROPLA ZDROWIA SPÓŁKA Z&nbsp;OGRANICZONĄ ODPOWIEDZIALNOŚCIĄ</strong> uznawany jest za&nbsp;Administratora danych, zaś&nbsp;Użytkownikowi przysługują wszystkie uprawnienia zawarte w&nbsp;<a href="/polityka-prywatnosci" target="_blank" rel="noopener noreferrer">Polityce prywatności</a>.</p>
<p style="text-align: justify;">Użytkownikiem jest każda osoba, której dane dotyczą, korzystająca z&nbsp;naszego Serwisu internetowego oraz&nbsp;innych powiązanych z&nbsp;nim witryn, komunikacji oraz&nbsp;usług (dalej jako <i>Użytkownik</i>).</p>
<ol style="list-style-type: upper-roman;">
<li style="text-align: justify;">PLIKI COOKIES
<p>Pliki cookies („ciasteczka”) to&nbsp;fragmenty kodu, które są plikami tekstowymi odpowiadającymi zapytaniom HTTP kierowanym do&nbsp;naszego serwera. Pliki te zapisywane są przez każdą przeglądarkę, z&nbsp;której Użytkownik odwiedza nasz&nbsp;Serwis. Dzięki informacjom zawartym w&nbsp;plikach cookies wiemy, w&nbsp;jaki sposób Użytkownicy korzystają z&nbsp;naszego Serwisu.</p>
<p>Pliki cookies służą nam do&nbsp;zapewnienia optymalnej obsługi wizyty Użytkownika w&nbsp;Serwisie oraz&nbsp;umożliwiają szybszy i&nbsp;łatwiejszy dostęp do&nbsp;informacji, a&nbsp;także w&nbsp;celu zaproponowania Użytkownikowi coraz doskonalszych funkcjonalności Serwisu internetowego oraz&nbsp;bardziej dopasowanych do&nbsp;Użytkownika treści.</p>
<p>Przechowywana informacja lub&nbsp;uzyskiwanie do&nbsp;niej dostępu nie&nbsp;powoduje zmian konfiguracyjnych w&nbsp;urządzeniu Użytkownika i&nbsp;oprogramowaniu na&nbsp;nim zainstalowanym.</p>
<p>Informacje zawarte w&nbsp;plikach cookies uznawane są za&nbsp;dane osobowe jedynie w&nbsp;powiązaniu z&nbsp;innymi danymi osobowymi dostępnymi na&nbsp;temat danego Użytkownika. My&nbsp;za&nbsp;pomocą plików cookies staramy&nbsp;się zbierać o&nbsp;Użytkowniku jedynie anonimowe dane, służące do&nbsp;wygody korzystania z&nbsp;portalu oraz&nbsp;minimalizacji uciążliwości reklam.</p>
</li>
<li style="text-align: justify;">RODZAJE I&nbsp;CELE KORZYSTANIA Z&nbsp;PLIKÓW COOKIES
<p>Korzystamy z&nbsp;plików cookies i&nbsp;innych podobnych technologii w&nbsp;celu rozpoznawania Użytkownika podczas jego&nbsp;wizyt w&nbsp;naszym Serwisie, zapamiętywania jego&nbsp;preferencji oraz&nbsp;wyświetlania mu odpowiednich, dostosowanych do&nbsp;niego treści. Dzięki plikom cookies interakcje Użytkownika z&nbsp;nami są szybsze i&nbsp;bardziej skuteczne. Ponadto pliki cookies umożliwiają nam prezentowanie Użytkownikowi dopasowanych do&nbsp;niego treści, bez&nbsp;konieczności przeprowadzania ankiet.</p>
<p>W Serwisie wykorzystywane są dwa rodzaje plików cookies:</p>
<ul>
<li>Cookies sesyjne – są to&nbsp;pliki tymczasowe, które pozostają na&nbsp;urządzeniu Użytkownika aż do&nbsp;opuszczenia przez niego Serwisu lub&nbsp;wyłączenia przeglądarki internetowej. W&nbsp;takim przypadku informacje zapisane w&nbsp;plikach cookies sesyjnych są automatycznie usuwane.</li>
<li>Cookies stałe (permanentne) – są to&nbsp;pliki, które pozostają na&nbsp;urządzeniu Użytkownika przez określony w&nbsp;parametrach plików cookies okres lub&nbsp;do&nbsp;momentu ich&nbsp;ręcznego usunięcia.</li>
</ul>
<p>W obszarze Serwisu wykorzystywane są również inne dostępne technologie, pozwalające na&nbsp;zapisywanie informacji w&nbsp;przeglądarce w&nbsp;odpowiednich magazynach danych (Session Storage, Local Storage), a&nbsp;także umieszczane są w&nbsp;fragmenty kodów narzędzi analitycznych dostarczanych przez innych dostawców, które umożliwiają zapisanie plików cookies w&nbsp;domenach tych usług.</p>
<p>Poniżej opisane zostały poszczególne kategorie cookies, które są wykorzystywane w&nbsp;naszym Serwisie:</p>
<p><strong>Cookies techniczne</strong>&nbsp;– są niezbędne, aby strona Serwisu mogła działać prawidłowo. Odnoszą&nbsp;się one&nbsp;do&nbsp;funkcjonalności naszych witryn internetowych i&nbsp;pozwalają nam ulepszyć usługi, które oferujemy za&nbsp;pośrednictwem naszych witryn internetowych, na&nbsp;przykład poprzez&nbsp;umożliwienie przenoszenia informacji między stronami naszej witryny internetowej, aby uniknąć konieczności ponownego wprowadzania informacji, lub&nbsp;rozpoznając preferencje Użytkownika po&nbsp;powrocie na&nbsp;stronę naszego Serwisu.</p>
<p>Wykorzystujemy je w&nbsp;celu:</p>
<ul>
<li>zapewnienia bezpieczeństwa;</li>
<li>utrzymania sesji, kiedy Użytkownik odwiedza i&nbsp;loguje&nbsp;się do&nbsp;swojego konta klienta;</li>
<li>zapewnienia odpowiedniego wyświetlanie strony – w&nbsp;zależności od&nbsp;tego, z&nbsp;jakiego urządzenia korzysta Użytkownik;</li>
<li>dostosowywania naszych usług do&nbsp;wyborów&nbsp;Użytkownika;</li>
<li>zapamiętania, czy&nbsp;Użytkownik wyraża zgodę na&nbsp;wyświetlanie niektórych treści.</li>
</ul>
<p><strong>Cookies analityczne</strong>&nbsp;– pozwalają nam rozpoznać i&nbsp;policzyć liczbę Użytkowników odwiedzających nasz&nbsp;Serwis, zobaczyć, w&nbsp;jaki sposób odwiedzający poruszają&nbsp;się po&nbsp;Serwisie, gdy z&nbsp;niego korzystają oraz&nbsp;rejestrować, które treści przeglądają i&nbsp;którymi są zainteresowani. Pomaga nam to&nbsp;określić, jak często strony i&nbsp;reklamy są odwiedzane oraz&nbsp;które obszary naszego Serwisu są najpopularniejsze. Umożliwia nam to&nbsp;ulepszanie oferowanych usług, sprawiając że nasi Użytkownicy znajdują informacje, których szukają. Są one&nbsp;również niezbędne,&nbsp;aby&nbsp;rozliczać&nbsp;się z&nbsp;naszymi Zaufanymi Partnerami, mierzyć efektywność naszych działań marketingowych bez&nbsp;identyfikacji danych osobowych.</p>
<p>Wykorzystujemy je w&nbsp;celu:</p>
<ul>
<li>badania statystyk dotyczących ruchu na&nbsp;stronie oraz&nbsp;sprawdzania źródła ruchu (kierunki przekierowania);</li>
&nbsp;
<li>wykrywania różnego rodzaju nadużyć np. sztuczny ruch internetowy (boty), ataki ddos;</li>
&nbsp;
<li>ograniczenia niepożądanych działań marketingowych;</li>
&nbsp;
<li>mierzenia &nbsp;skuteczności akcji marketingowych prowadzonych na&nbsp;rzecz Serwisu, np. w&nbsp;sieci reklamowej Google, w&nbsp;programach partnerskich, na&nbsp;zewnętrznych stronach internetowych;</li>
&nbsp;
<li>rozliczania&nbsp;się z&nbsp;Zaufanymi Partnerami za&nbsp;usługi reklamowe w&nbsp;oparciu o&nbsp;aktywność użytkownika &nbsp;np. kliknięcia.</li>
&nbsp;</ul>
<p>Cookies marketingowe&nbsp;– są używane, gdy Użytkownik wyrazi na&nbsp;to&nbsp;zgodę i&nbsp;tylko&nbsp;wtedy gdy zastosowane przez nasz&nbsp;Serwis funkcjonalności oraz&nbsp;formy reklamy tego wymagają.</p>
<p>Wykorzystujemy je w&nbsp;celu:</p>
<ul>
<li>wyświetlania reklam, które są istotne i&nbsp;interesujące dla konkretnego użytkownika. Dotyczą profilowania reklam &nbsp;wyświetlanych zarówno na&nbsp;zewnętrznych serwisach internetowych, jak i&nbsp;na&nbsp;stronie naszego Serwisu, stosownie do&nbsp;preferencji użytkowników w&nbsp;zakresie wyboru towarów, na&nbsp;podstawie danych posiadanych przez Serwis, w&nbsp;tym zachowania użytkowników w&nbsp;Serwisie.&nbsp;</li>
</ul>
<p>Wchodząc na&nbsp;stronę Serwisu, Użytkownik może nie&nbsp;zgodzić&nbsp;się na&nbsp;korzystanie z&nbsp;plików cookies analitycznych i&nbsp;marketingowych. Wówczas nie&nbsp;będziemy mogli prowadzić szczegółowych statystyk oraz&nbsp;dostosowywać naszych reklam w&nbsp;oparciu o&nbsp;informacje zebrane w&nbsp;naszym Serwisie. Nadal jednak będą wyświetlane reklamy o&nbsp;charakterze ogólnym zarówno na&nbsp;stronie Serwisu, jak i&nbsp;na&nbsp;innych serwisach internetowych.</p>
<p>Do emisji reklam w&nbsp;Internecie, a&nbsp;także w&nbsp;zakresie innych narzędzi takich jak Google reCAPTCHA (narzędzie do&nbsp;ochrony przed spamem), wykorzystujemy technologie dostarczane przez firmy Google i&nbsp;Meta (Facebook), dlatego zwróć uwagę, czy&nbsp;wyrażasz zgodę na&nbsp;stosowanie tych narzędzi, w&nbsp;tym profilowanie reklam w&nbsp;Internecie i&nbsp;na&nbsp;Facebooku. Możesz sprawdzić oraz&nbsp;zarządzać swoimi ustawieniami prywatności i&nbsp;bezpieczeństwa na&nbsp;koncie Google, korzystając z&nbsp;linku g.co/privacytools. Więcej informacji na&nbsp;temat polityki prywatności Google, technologii stosowanych przez Google oraz&nbsp;warunków korzystania z&nbsp;usług Google znajdziesz na&nbsp;stronie https://policies.google.com/privacy?hl=pl#infochoices. Informacje na&nbsp;temat zasad ochrony prywatności stosowanych przez firmę Meta (Facebook) oraz&nbsp;zarządzania ustawieniami prywatności są dostępne na&nbsp;stronie https://pl-pl.facebook.com/privacy/explanation/.</p>
<p>Bardziej szczegółowe informacje o&nbsp;używanych przez nas plikach cookie, czasie przechowywania oraz&nbsp;aktualnej liście zewnętrznych firm, z&nbsp;których usług korzystamy lub&nbsp;których technologie umieszczamy w&nbsp;naszym Serwisie, znajdziesz w&nbsp;<a href="/tabela-cookies" target="_blank" rel="noopener noreferrer">Tabeli Cookies</a>.</p>
</li>
<li style="text-align: justify;">WYŁĄCZENIE OBSŁUGI PLIKÓW COOKIES
<p>Przeglądarki internetowe domyślnie dopuszczają przechowywanie plików cookies. Jeśli Użytkownik nie&nbsp;chce otrzymywać plików cookies, może zmienić ustawienia swojej przeglądarki na&nbsp;komputerze lub&nbsp;innym urządzeniu, z&nbsp;którego korzysta w&nbsp;celu dostępu do&nbsp;naszego Serwisu. Dalsze korzystanie przez Użytkownika z&nbsp;naszego Serwisu bez&nbsp;zmiany ustawień oznacza, że Użytkownik zgadza&nbsp;się na&nbsp;otrzymywanie plików cookies technicznych w&nbsp;naszym Serwisie, które jak wskazaliśmy są dla nas niezbędne do&nbsp;prawidłowego funkcjonowania strony Serwisu.</p>
<p>Większość przeglądarek internetowych posiada funkcję, która pozwala Użytkownikowi przeglądać i&nbsp;usuwać pliki cookie, w&nbsp;tym pliki cookie w&nbsp;naszym serwisie. Jednakże podkreślić należy, że brak możliwości zapisywania lub&nbsp;odczytywania plików cookies przez stronę internetową naszego Serwisu może uniemożliwić pełne i&nbsp;poprawne korzystanie z&nbsp;naszego Serwisu.</p>
<p>Jeżeli Użytkownik używa różnych urządzeń do&nbsp;uzyskania dostępu do&nbsp;naszego Serwisu oraz&nbsp;jego&nbsp;przeglądania (np. komputera, smartfona, tabletu), powinien upewnić się, że każda przeglądarka na&nbsp;każdym urządzeniu dostosowana jest do&nbsp;preferencji związanych z&nbsp;plikami cookies.</p>
<p>Sposób wyłączenia obsługi plików cookies zależy od&nbsp;przeglądarki, z&nbsp;której Użytkownik korzysta. Poniżej wskazany został sposób, w&nbsp;jaki Użytkownik może wyłączyć obsługę plików cookies w&nbsp;przeglądarce Google Chrome, Firefox, Safari, Opera oraz&nbsp;Internet Explorer.</p>
<ol style="list-style-type: decimal;">
<li>
<strong>Wyłączenie obsługi plików cookies w&nbsp;przeglądarce Google Chrome</strong>
<ol style="list-style-type: decimal;">
<li>W prawy górnym rogu przy pasku adresu przeglądarki Google Chrome wybierz trzy kropki pionowe.</li>
<li>W sekcji <i>Prywatność bezpieczeństwo</i> kliknij przycisk <i>Treść</i>.</li>
<li>W sekcji <i>Pliki cookies i&nbsp;dane stron</i> możesz zmienić następujące ustawienia plików cookies:
<ul>
<li><i>Blokuj wszystkie pliki cookies</i></li>
<li><i>Blokuj pliki cookies innych firm </i></li>
</ul>
</li>
</ol>
<p>Więcej informacji o&nbsp;ustawieniach przeglądarki Google Chrome:</p>
<a href="https://support.google.com/chrome/#topic=7438008" target="_blank" rel="noopener noreferrer">https://support.google.com/chrome/#topic=7438008</a>
</li>
<li>
<strong>Wyłączenie obsługi plików cookies w&nbsp;przeglądarce Firefox</strong>
<ol style="list-style-type: decimal;">
<li>W prawym górnym rogu okna przeglądarki Firefox kliknij <i>Otwórz menu</i> (trzy poziome kreski) i&nbsp;wybierz <i>Ustawienia</i>.</li>
<li>Następnie z&nbsp;sekcji <i>Prywatność i&nbsp;bezpieczeństwo</i> wybierz zakładkę ciasteczka i&nbsp;dane witryn.</li>
<li>Wybierz odpowiedni poziom bezpieczeństwa lub&nbsp;skonfiguruj własny wybierając które elementy i&nbsp;skrypty blokować - <i>ciasteczka</i>:
<ul>
<li><i>Wszystkie z&nbsp;zewnętrznych witryn</i></li>
<li><i>Wszystkie</i></li>
</ul>
</li>
</ol>
<p>Więcej informacji o&nbsp;ustawieniach przeglądarki Firefox:</p>
<a href="https://support.mozilla.org/pl/kb/W%C5%82%C4%85czanie%20i%20wy%C5%82%C4%85czanie%20obs%C5%82ugi%20ciasteczek" target="_blank" rel="noopener noreferrer">https://support.mozilla.org/pl/kb/W%C5%82%C4%85czanie%20i%20wy%C5%82%C4%85czanie%20obs%C5%82ugi%20ciasteczek </a>
</li>
<li>
<strong>Wyłączenie obsługi plików cookies w&nbsp;przeglądarce Safari </strong>
<p>Wybierz polecenie menu <i>Safari &gt; Preferencje</i>, kliknij w&nbsp;<i>Prywatność</i>, a&nbsp;następnie wykonaj dowolną z&nbsp;poniższych czynności:</p>
<ul>
<li><i>Blokuj wszystkie cookie</i></li>
<li><i>Zapobiegaj śledzeniu poza witryną</i></li>
</ul>
<p>Więcej informacji o&nbsp;ustawieniach przeglądarki Safari:</p>
<a href="https://support.apple.com/kb/PH19214?viewlocale=pl_PL&amp;locale=pl_PL" target="_blank" rel="noopener noreferrer">https://support.apple.com/kb/PH19214?viewlocale=pl_PL&amp;locale=pl_PL</a>
</li>
<li>
<strong>Wyłączenie obsługi plików cookies w&nbsp;przeglądarce Opera</strong>
<ol style="list-style-type: decimal;">
<li>W prawy górnym rogu przy pasku adresu przeglądarki Opera wybierz trzy linie poziome.</li>
<li>Kliknij przejdź do&nbsp;pełnych ustawień przeglądarki.</li>
<li>W sekcji <i>Prywatność bezpieczeństwo</i> kliknij przycisk <i>Ciasteczka i&nbsp;inne dane witryn</i>.</li>
<li>Możesz zmienić następujące ustawienia plików cookies:
<ul>
<li><i>Blokuj wszystkie pliki cookies</i></li>
<li><i>Blokuj pliki cookies innych firm</i></li>
</ul>
</li>
</ol>
<p>Więcej informacji o&nbsp;ustawieniach przeglądarki Opera:</p>
<a href="http://help.opera.com/Windows/12.10/pl/cookies.html" target="_blank" rel="noopener noreferrer">http://help.opera.com/Windows/12.10/pl/cookies.html </a>
</li>
<li>
<strong>Wyłączenie obsługi plików cookies w&nbsp;przeglądarce Edge</strong>
<ol style="list-style-type: decimal;">
<li>W prawy górnym rogu przy pasku adresu przeglądarki Edge wybierz trzy kropki poziome.</li>
<li>Kliknij <i>Ustawienia</i>.</li>
<li>W sekcji <i>Pliki cookie i&nbsp;uprawnienia witryn</i> kliknij <i>Zarządzaj plikami cookie i&nbsp;danymi witryn oraz&nbsp;usuwaj je</i>.</li>
<li>Możesz zmienić następujące ustawienia plików cookies:
<ul>
<li><i>Blokuj</i></li>
<li><i>Blokuj pliki cookies innych firm</i></li>
</ul>
</li>
</ol>
<p>Więcej informacji o&nbsp;ustawieniach przeglądarki Edge:</p>
<a href="https://support.microsoft.com/pl-pl/microsoft-edge" target="_blank" rel="noopener noreferrer">https://support.microsoft.com/pl-pl/microsoft-edge </a>
</li>
</ol>
</li>
<li>INFORMACJE KONTAKTOWE
<p style="text-align: justify;">W razie jakichkolwiek wątpliwości związanych z&nbsp;kwestiami niniejszej Polityki Cookies lub&nbsp;w&nbsp;celu uzyskania informacji dotyczących niniejszej Polityki Cookies Użytkownik może skontaktować&nbsp;się z&nbsp;Administratorem za&nbsp;pośrednictwem wiadomości e-mail <strong><a href="mailto:kroplazdrowiapl@gmail.com">kroplazdrowiapl@gmail.com</a></strong> oraz&nbsp;drogą pocztową na&nbsp;adres Administratora.</p>
</li>
</ol>
</div></div>',0,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('obowiazek-informacyjny','legal','Obowiązek informacyjny','Obowiązek Informacyjny','Obowiązek informacyjny',null,'/images/design/banner.webp','<div class="row"><div class="col-md-12" id="boxx">
<h1 style="text-align: left;">Obowiązek Informacyjny</h1>
<p style="text-align: justify;">Administratorem danych osobowych Użytkownika udostępnionych za&nbsp;pośrednictwem Serwisu, czyli&nbsp;podmiotem decydującym o&nbsp;celach i&nbsp;sposobach ich&nbsp;przetwarzania, jest <strong> KROPLA ZDROWIA SPÓŁKA Z&nbsp;OGRANICZONĄ ODPOWIEDZIALNOŚCIĄ, ul. Strażacka 81, 43-382 Bielsko-Biała, NIP 5472234073, </strong> <em>(dalej jako Administrator)</em>.</p>
<p style="text-align: justify;">Podane przez Użytkownika dane osobowe są przetwarzane przez Administratora na&nbsp;podstawie zgody wyrażonej przez Użytkownika, w&nbsp;rozumieniu art. 6 ust. 1 lit. a)Rozporządzenia Parlamentu Europejskiego i&nbsp;Rady (UE) 2016/679 z&nbsp;dnia 27 kwietnia 2016 r. w&nbsp;sprawie ochrony osób fizycznych w&nbsp;związku z&nbsp;przetwarzaniem danych osobowych i&nbsp;w&nbsp;sprawie swobodnego przepływu takich danych oraz&nbsp;uchylenia dyrektywy 95/46/WE - zwanego dalej RODO.</p>
<p style="text-align: justify;">Podanie danych osobowych za&nbsp;pośrednictwem Serwisu jest dobrowolne. Użytkownik ma prawo do&nbsp;cofnięcia wyrażonej zgody w&nbsp;dowolnym momencie poprzez&nbsp;kontakt z&nbsp;Administratorem <strong> <a href="mailto:kroplazdrowiapl@gmail.com">kroplazdrowiapl@gmail.com</a>,</strong> bez&nbsp;wpływu na&nbsp;zgodność z&nbsp;prawem przetwarzania, którego dokonano na&nbsp;podstawie zgody przed jej&nbsp;cofnięciem.</p>
<p style="text-align: justify;">Użytkownikowi przysługuje prawo dostępu do&nbsp;swoich danych osobowych w&nbsp;każdym czasie, ich&nbsp;sprostowania, usunięcia lub&nbsp;ograniczenia przetwarzania oraz&nbsp;prawo do&nbsp;wniesienia sprzeciwu wobec przetwarzania, a&nbsp;także prawo do&nbsp;przenoszenia danych.</p>
<p style="text-align: justify;">Administrator przetwarza dane osobowe Użytkownika Serwisu w&nbsp;następujących celach:</p>
<ol style="text-align: justify;">
<li>Komunikacji z&nbsp;Użytkownikiem, w&nbsp;szczególności obsługi reklamacji dotyczących produktów lub&nbsp;usług Administratora;</li>
<li>Przedstawiania Użytkownikowi ofert handlowych drogą elektroniczną;</li>
<li>Przedstawiania Użytkownikowi ofert handlowych w&nbsp;kontakcie telefonicznym;</li>
<li>Przesyłania Użytkownikowi informacji drogą elektroniczną w&nbsp;ramach zapisu na&nbsp;newsletter Administratora;</li>
<li>Umożliwienia Użytkownikowi przesyłania komentarzy lub&nbsp;opinii dotyczących produktów lub&nbsp;usług Administratora.</li>
</ol>
<p style="text-align: justify;">Administrator może przetwarzać dane osobowe Użytkownika pozyskane za&nbsp;pośrednictwem Serwisu również w&nbsp;następujących celach:</p>
<ol style="text-align: justify;">
<li>w celu zawarcia i&nbsp;realizacji ewentualnej umowy pomiędzy Użytkownikiem a&nbsp;Administratorem oraz&nbsp;obsługi Użytkownika jako klienta Administratora zgodnie z&nbsp;art. 6 ust. 1 lit. b) RODO;</li>
<li>w celu prowadzenia rozliczeń finansowych z&nbsp;Użytkownikiem będącym klientem Administratora tytułem realizacji ewentualnej umowy zawartej między stronami, a&nbsp;także ewentualnego dochodzenia roszczeń od&nbsp;Użytkownika będącego klientem w&nbsp;ramach prawnie uzasadnionego interesu Administratora zgodnie z&nbsp;art. 6 ust. 1 lit. f) RODO oraz&nbsp;spełnienia obowiązków prawnych Administratora wobec organów podatkowych na&nbsp;podstawie odrębnych przepisów zgodnie z&nbsp;art. 6 ust. 1 lit. c) RODO;</li>
<li>w celu realizacji działań marketingowych Administratora w&nbsp;ramach prawnie uzasadnionego interesu Administratora w&nbsp;rozumieniu art. 6 ust. 1 lit. f) RODO, a&nbsp;także zgodnie z&nbsp;oświadczeniami woli dotyczącymi komunikacji marketingowej złożonymi wobec Administratora. Zgody udzielone w&nbsp;zakresie komunikacji marketingowej (np. na&nbsp;przesyłanie informacji handlowych drogą elektroniczną lub&nbsp;kontakt telefoniczny w&nbsp;celach marketingu bezpośredniego) mogą być wycofane w&nbsp;dowolnym czasie, bez&nbsp;wpływu na&nbsp;zgodność z&nbsp;prawem przetwarzania, którego dokonano na&nbsp;podstawie zgody przed jej&nbsp;cofnięciem;</li>
<li>w celu realizacji obowiązków prawnych Administratora wobec Użytkownika określonych w&nbsp;RODO, w&nbsp;rozumieniu art. 6 ust. 1 lit. c) RODO.</li>
</ol>
<p style="text-align: justify;">Więcej informacji dotyczących powyższych celów przetwarzania danych osobowych Użytkownika znajduje&nbsp;się w&nbsp;<a href="/polityka-prywatnosci" target="_blank" rel="noopener noreferrer">Polityce prywatności</a> opublikowanej w&nbsp;Serwisie.</p>
<p style="text-align: justify;">Dane osobowe Użytkownika są lub&nbsp;mogą być przekazywane następującym kategoriom odbiorców:</p>
<ol style="text-align: justify;">
<li>dostawcom usług reklamowych lub&nbsp;marketingowych;</li>
<li>zewnętrznym firmom sprzedażowym.</li>
</ol>
<p style="text-align: justify;">Administrator przechowuje dane osobowe przez taki&nbsp;okres, jaki jest konieczny do&nbsp;osiągnięcia określonych celów, tj.:</p>
<ul style="text-align: justify;">
<li>przez okres prowadzenia działalności gospodarczej przez Administratora.</li>
</ul>
<p style="text-align: justify;">W przypadku jakichkolwiek pytań lub&nbsp;problemów związanych z&nbsp;przetwarzaniem danych osobowych należy kontaktować&nbsp;się z&nbsp;Administratorem pod&nbsp;następującym adresem: <br><strong> ul. Strażacka 81, 43-382 Bielsko-Biała, <a href="mailto:kroplazdrowiapl@gmail.com">kroplazdrowiapl@gmail.com</a>. </strong></p>
<p style="text-align: justify;">Użytkownik ma prawo do&nbsp;wniesienia skargi do&nbsp;Prezesa Urzędu Ochrony Danych Osobowych.</p>
</div></div>',0,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('mechanika-oraz-diagnostyka-samochodowa','service','Mechanika oraz diagnostyka samochodowa','Mechanika i diagnostyka samochodowa','Mechanika oraz diagnostyka samochodów dostawczych i osobowych','Oferujemy usługi z zakresu mechaniki oraz diagnostyki samochodowej. Zajmujemy się między innymi naprawą i konserwacją samochodów osobowych oraz dostawczych.','/images/design/banner.webp','<div class="row"><div class="col-md-12"><h1>Mechanika i&nbsp;diagnostyka samochodowa</h1></div></div>
<div class="row">
<div class="col-md-4 well-2 margin-top-xl-lg-md margin-top-sm margin-top-xs"><p>Oferujemy szeroki zakres usług związanych z&nbsp;<strong>mechaniką i&nbsp;diagnostyką samochodową</strong>. Nasza oferta obejmuje przeglądy samochodów, wymianę oleju i&nbsp;filtrów, naprawę układu hamulcowego, a&nbsp;także <strong>diagnostykę komputerową</strong>. Dzięki nowoczesnym narzędziom i&nbsp;doświadczeniu naszych mechaników, jesteśmy w&nbsp;stanie szybko i&nbsp;skutecznie zdiagnozować i&nbsp;naprawić wszelkie usterki. Dbamy o&nbsp;to, aby nasze usługi były na&nbsp;najwyższym poziomie, dlatego stale inwestujemy w&nbsp;rozwój naszego warsztatu i&nbsp;szkolenie pracowników. Naszym celem jest zapewnienie klientom bezpieczeństwa i&nbsp;komfortu podczas jazdy.</p></div>
<div class="col-md-8 margin-top-xl-lg-md margin-top-sm margin-top-xs brr-md-img shadow-img-1 margin-bottom-sm margin-bottom-xl-lg-md margin-bottom-xs"><p><img src="/images/design/content-oferta-mechanika-oraz-diagnostyka-samochodowa.webp" alt="Wycieranie silnika" width="770" height="500"></p></div>
</div>
<div class="row"><div class="margin-top-xl-lg-md margin-top-sm margin-top-xs col-md-12">
<h2>Modele i&nbsp;marki samochodów, którymi zajmujemy&nbsp;się w&nbsp;Soft Car Service</h2>
<p>W naszym warsztacie zajmujemy&nbsp;się <strong>naprawą i&nbsp;serwisem samochodów różnych marek i&nbsp;modeli</strong>. Mamy doświadczenie w&nbsp;pracy z&nbsp;samochodami europejskimi, azjatyckimi, a&nbsp;także amerykańskimi. Specjalizujemy&nbsp;się w&nbsp;naprawie pojazdów marki BMW i&nbsp;MINI, ale&nbsp;nasza oferta obejmuje również usługi dla samochodów producentów takich jak KIA, HYUNDAI, czy&nbsp;aut francuskich. Niezależnie od&nbsp;marki i&nbsp;modelu Twojego samochodu, możesz liczyć na&nbsp;profesjonalną obsługę i&nbsp;najwyższą jakość usług. Zapraszamy do&nbsp;kontaktu i&nbsp;skorzystania z&nbsp;naszej oferty.</p>
</div></div>',10,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('naprawy-ukladu-hamulcowego','service','Naprawy układu hamulcowego','Naprawy układu hamulcowego','Naprawy układu hamulcowego – Soft Car Service',null,'/images/design/banner.webp','',20,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('naprawa-zawieszenia-i-silnikow','service','Naprawa zawieszenia i silników','Naprawa zawieszenia - klucz do komfortu i bezpieczeństwa','Naprawa zawieszenia samochodowego - Bezpieczeństwo na drodze','Profesjonalna naprawa zawieszenia. Zapewniamy kompleksowe usługi związane z naprawą i konserwacją zawieszenia samochodowego. Skontaktuj się z nami już dziś!','/images/design/banner.webp','<div class="row"><div class="col-md-12"><h1>Naprawa zawieszenia - klucz do&nbsp;komfortu i&nbsp;bezpieczeństwa</h1></div></div>
<div class="row">
<div class="col-md-4 well-2 margin-top-xl-lg-md margin-top-sm margin-top-xs"><p><span>Zawieszenie samochodowe pełni niezwykle istotną rolę w&nbsp;funkcjonowaniu każdego pojazdu. Dzięki niemu jazda staje&nbsp;się komfortowa i&nbsp;bezpieczna, a&nbsp;samochód utrzymuje odpowiednią przyczepność do&nbsp;nawierzchni. W&nbsp;naszym warsztacie Soft Car Service oferujemy szeroki zakres usług związanych z&nbsp;naprawą zawieszenia, takich jak wymiana amortyzatorów, końcówek drążka kierowniczego, sworzni wahacza, tulei wahacza, łączników stabilizatora i&nbsp;wielu innych. Nasz&nbsp;zespół doświadczonych mechaników korzysta z&nbsp;najnowocześniejszych narzędzi i&nbsp;technologii, aby zapewnić najwyższą jakość usług. Niezależnie od&nbsp;marki i&nbsp;modelu Twojego samochodu, jesteśmy gotowi sprostać wszystkim Twoim potrzebom związanym z&nbsp;naprawą zawieszenia.</span></p></div>
<div class="col-md-8 margin-top-xl-lg-md margin-top-sm margin-top-xs brr-md-img shadow-img-1 margin-bottom-sm margin-bottom-xs margin-bottom-xl-lg-md"><p><img src="/images/design/content-naprawa-zawieszenia.webp" alt="Urządzenie do&nbsp;sprawdzenia zawieszenia" width="770" height="500"></p></div>
</div>
<div class="row"><div class="col-md-12">
<p>&nbsp;</p>
<p>&nbsp;</p>
</div></div>
<div class="row"><div class="col-md-12"><p>W ofercie naszych usług znajdują&nbsp;się między innym:</p></div></div>
<div class="row">
<div class="col-md-3"><div class="gmail-pozycjacennika gmail-bn">
<ul>
<li class="gmail-nazwa-ceny">Wymiana paska napędu osprzętu<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana rozrządu (pasek)<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana rozrządu (łańcuch)<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana uszczelki pod&nbsp;głowicą<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana silnika&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</li>
</ul>
</div></div>
<div class="col-md-3"><ul>
<li>&nbsp;Wymiana świec zapłonowych 1 szt<br><br>
</li>
<li>Wymiana świec żarowych 1 szt<br><br>
</li>
<li>Odkręcenie urwanej świecy żarowej<br><br>
</li>
<li>Wymiana wtryskiwacza diesel<br><br>
</li>
<li>Wymiana sprzęgła&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</li>
</ul></div>
<div class="col-md-3"><div class="gmail-pozycjacennika gmail-bt">
<ul>
<li class="gmail-nazwa-ceny">Wymiana alternatora<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana rozrusznika<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana turbosprężarki (konieczna wymiana oleju)<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana pompy wody<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana pompy paliwa benzyna&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</li>
</ul>
</div></div>
<div class="col-md-3"><div class="gmail-pozycjacennika gmail-bt">
<ul>
<li class="gmail-nazwa-ceny">Wymiana Pompy paliwa Wysokłego diesel<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana linki sprzęgła<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana chłodnicy wody<br><br>
</li>
<li class="gmail-nazwa-ceny">Wymiana skrzyni biegów&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</li>
</ul>
</div></div>
</div>
<div class="row"><div class="col-md-12">
<div>Lista naszych usług stale&nbsp;się poszerza, zapraszamy do&nbsp;kontaktu telefonicznego w&nbsp;celu uzyskania rzetelnych informacji</div>
<div>&nbsp;</div>
<div>Cennik usług serwisowych Soft Car Service obejmuje usługi diagnostyczne, naprawy poszczególnych układów oraz&nbsp;usługi dodatkowe. Podane ceny brutto są orientacyjne i&nbsp;obejmują tylko&nbsp;koszty robocizny. Ceny uzależnione są od&nbsp;modelu pojazdu oraz&nbsp;&nbsp;od&nbsp;stopnia skomplikowania i&nbsp;uzgadniane są zawsze indywidualnie z&nbsp;klientem. W&nbsp;przypadku gdy klient chce przywieźć własne części do&nbsp;cen usług doliczamy 20%<br>Żeby dowiedzieć&nbsp;się o&nbsp;dokładny koszt, skontaktuj&nbsp;się z&nbsp;nami pod&nbsp;numerem tel. <a href="tel:739533830">739 533 830</a> lub&nbsp;mailowo: &nbsp;<a href="mailto:office.softcarservice@gmail.com">office.softcarservice@gmail.com</a>.<br><br>W Soft Car Service naprawiamy samochody wszystkich marek i&nbsp;dajemy gwarancję na&nbsp;wykonane prace oraz&nbsp;zakupione u&nbsp;nas części.</div>
</div></div>
<div class="row"><div class="margin-top-xl-lg-md margin-top-sm margin-top-xs col-md-12">
<h2>Elementy zawieszenia, które najczęściej wymagają naprawy</h2>
<p>Najczęściej naprawianymi elementami zawieszenia są amortyzatory, końcówki drążka kierowniczego, sworznie wahacza, tuleje wahacza i&nbsp;łączniki stabilizatora. <strong>Amortyzatory</strong> są kluczowym elementem zawieszenia, który absorbują drgania i&nbsp;wstrząsy podczas jazdy, zapewniając komfort i&nbsp;stabilność. <strong>Końcówki drążka kierowniczego, sworznie wahacza i&nbsp;tuleje wahacza</strong> są odpowiedzialne za&nbsp;prawidłowe działanie układu kierowniczego, a&nbsp;ich&nbsp;uszkodzenie może prowadzić do&nbsp;problemów z&nbsp;prowadzeniem pojazdu. <strong>Łączniki stabilizatora</strong>, z&nbsp;kolei, pomagają utrzymać równowagę pojazdu podczas jazdy po&nbsp;nierównościach. Wszystkie te elementy są narażone na&nbsp;zużycie i&nbsp;mogą wymagać naprawy lub&nbsp;wymiany w&nbsp;różnych okresach eksploatacji samochodu.</p>
</div></div>',30,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('serwis-klimatyzacji-samochodowej','service','Serwis klimatyzacji samochodowej','Serwis Klimatyzacji Samochodowej w Czechowicach-Dziedzicach Soft Car Service','Naprawy układu hamulcowego – diagnoza i serwis usterek','Jesteśmy firmą świadczącą usługi związane z naprawą układu hamulcowego. Zapewniamy kompleksową obsługę i wysokiej jakości serwis dla Twojego samochodu.','/images/design/banner.webp','<div class="row"><div class="col-md-12"><h1>Serwis Klimatyzacji Samochodowej w&nbsp;Czechowicach-Dziedzicach Soft Car Service</h1></div></div>
<div class="row">
<div class="well-2 margin-top-xl-lg-md margin-top-sm margin-top-xs col-md-6">
<p>Serwis Klimatyzacji Samochodowej w&nbsp;Czechowicach-Dziedzicach &nbsp;Soft Car Service</p>
<p>Klimatyzacja w&nbsp;samochodzie to&nbsp;nie&nbsp;tylko&nbsp;luksus, ale&nbsp;także istotny element komfortu i&nbsp;bezpieczeństwa w&nbsp;czasie podróży, zwłaszcza w&nbsp;gorące dni. W&nbsp;Soft Car Service w&nbsp;Czechowicach oferujemy profesjonalny serwis klimatyzacji samochodowej, który zapewni nie&nbsp;tylko&nbsp;przyjemny chłód w&nbsp;kabinie, ale&nbsp;także dbałość o&nbsp;zdrowie i&nbsp;sprawność systemu klimatyzacyjnego w&nbsp;Twoim pojeździe.</p>
</div>
<div class="margin-top-xl-lg-md margin-top-sm margin-top-xs brr-md-img shadow-img-1 margin-bottom-sm margin-bottom-xl-lg-md margin-bottom-xs col-md-6"><p><img src="/images/design/content-klimatyzacja.webp" alt="klimatyzacja" width="800" height="671"></p></div>
</div>
<div class="row"><div class="col-md-12">
<h2>Dlaczego serwis klimatyzacji jest ważny?</h2>
<ul>
<li>Klimatyzacja w&nbsp;samochodzie pełni kluczową rolę w&nbsp;utrzymaniu odpowiedniej temperatury i&nbsp;wilgotności powietrza w&nbsp;kabinie, co wpływa na&nbsp;komfort jazdy. Regularna konserwacja i&nbsp;serwis klimatyzacji są niezbędne, aby:</li>
<li>Zwiększyć efektywność chłodzenia – Nieszczelności w&nbsp;układzie czy&nbsp;zużycie komponentów mogą powodować, że klimatyzacja nie&nbsp;działa prawidłowo, co zmniejsza komfort podróży.</li>
<li>Zachować zdrowie – Regularna dezynfekcja klimatyzacji zapobiega rozwojowi bakterii, grzybów i&nbsp;nieprzyjemnych zapachów, które mogą wpływać na&nbsp;Twoje zdrowie.</li>
<li>Wydłużyć żywotność systemu – Profesjonalny serwis zapobiega poważnym awariom, które mogą wiązać&nbsp;się z&nbsp;kosztownymi naprawami.</li>
<li>Oszczędność paliwa – Sprawny układ klimatyzacji zmniejsza zużycie paliwa i&nbsp;poprawia ogólną wydajność samochodu.</li>
</ul>
<p>&nbsp;</p>
<h2>Kiedy należy wykonać serwis klimatyzacji?</h2>
<p>Rekomendujemy wykonanie serwisu klimatyzacji co najmniej raz do&nbsp;roku, najlepiej przed rozpoczęciem sezonu letniego, aby zapewnić jej&nbsp;maksymalną wydajność. Warto również zwrócić uwagę na&nbsp;wszelkie objawy, które mogą wskazywać na&nbsp;konieczność naprawy klimatyzacji, takie jak:</p>
<ul>
<li>Niewystarczająca wydajność chłodzenia,</li>
<li>Nieprzyjemny zapach dochodzący z&nbsp;nawiewów,</li>
<li>Dziwne dźwięki podczas pracy klimatyzacji,</li>
<li>Wilgoć lub&nbsp;parowanie szyb.</li>
</ul>
<p>&nbsp;</p>
<h2>Dlaczego warto wybrać Soft Car Service w&nbsp;Czechowicach?</h2>
<p>&nbsp; &nbsp; W&nbsp;Soft Car Service w&nbsp;Czechowicach-Dziedzicach na&nbsp;ul. Legionów 124 oferujemy kompleksowy serwis klimatyzacji samochodowej. Nasz&nbsp;zespół doświadczonych mechaników posiada wieloletnią praktykę w&nbsp;naprawach i&nbsp;konserwacji systemów klimatyzacyjnych w&nbsp;różnych modelach samochodów. Gwarantujemy:</p>
<ul>
<li>Szeroki zakres usług – od&nbsp;napełniania klimatyzacji, przez diagnostykę, po&nbsp;naprawę nieszczelności i&nbsp;wymianę komponentów.</li>
<li>Profesjonalne podejście – korzystamy z&nbsp;nowoczesnego sprzętu, który pozwala na&nbsp;precyzyjne diagnozowanie problemów i&nbsp;skuteczną naprawę.</li>
<li>Bezpieczeństwo i&nbsp;higiena – wykonujemy dezynfekcję układu klimatyzacji, usuwając nie&nbsp;tylko&nbsp;zabrudzenia, ale&nbsp;także mikroorganizmy, które mogą zagrażać zdrowiu.</li>
<li>Atrakcyjne ceny i&nbsp;szybka obsługa – staramy się, aby każdy klient był zadowolony z&nbsp;jakości naszych usług w&nbsp;konkurencyjnych cenach.</li>
<li>Oferujemy kompleksowy serwis klimatyzacji samochodowej, obejmujący:</li>
</ul>
<p>&nbsp; &nbsp; ✔️ Diagnostykę i&nbsp;sprawdzenie szczelności układu,<br>&nbsp; &nbsp; ✔️ Uzupełnienie czynnika chłodniczego (R134a),<br>&nbsp; &nbsp; ✔️ Ozonowanie i&nbsp;odgrzybianie klimatyzacji,<br>&nbsp; &nbsp; ✔️ Naprawę i&nbsp;konserwację układu klimatyzacji.</p>
<p>&nbsp;</p>
<p>Zaufaj doświadczeniu naszych mechaników i&nbsp;zadbaj o&nbsp;swoją klimatyzację w&nbsp;Soft Car Service! Zapewniamy niezawodność, komfort i&nbsp;bezpieczeństwo podczas każdej podróży.</p>
<p>Sprawdź nasz&nbsp;cennik!</p>
<p>Koszt serwisu klimatyzacji zależy od&nbsp;zakresu usług i&nbsp;modelu pojazdu. Aktualne ceny znajdziesz na&nbsp;naszej stronie internetowej:<br>➡️ <a href="/cennik">softcarservice.pl/cennik</a></p>
<p>Nie czekaj – zadbaj o&nbsp;swoją klimatyzację już dziś!</p>
<p>Umów wizytę w&nbsp;Soft Car Service w&nbsp;Czechowicach i&nbsp;ciesz&nbsp;się komfortową jazdą bez&nbsp;względu na&nbsp;pogodę. <a href="tel:+48739533830">Skontaktuj&nbsp;się z&nbsp;nami telefonicznie</a> lub&nbsp;odwiedź nasz&nbsp;warsztat!</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div></div>',40,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('sezonowe-przechowywanie-opon','service','Sezonowe przechowywanie opon','Sezonowe przechowywanie opon','Sezonowe przechowywanie opon i felg – bezpieczeństwo oraz wygoda','Zapomnij o troskach związanych z przechowywaniem opon i felg! Oferujemy sezonowe przechowywanie, aby Twoje opony i felgi były zawsze gotowe na zmianę pór roku.','/images/design/banner.webp','<div class="row"><div class="col-md-12"><h1>Sezonowe przechowywanie opon</h1></div></div>
<div class="row">
<div class="col-md-4 well-2 margin-top-xl-lg-md margin-top-sm margin-top-xs"><p>Jako firma specjalizująca&nbsp;się w&nbsp;przechowywaniu <strong>opon i&nbsp;felg</strong>, jesteśmy dumni z&nbsp;dostarczania wyjątkowych rozwiązań w&nbsp;zakresie przechowywania wszystkich rodzajów opon i&nbsp;felg. Dzięki wieloletniemu doświadczeniu w&nbsp;branży rozumiemy różne potrzeby każdego klienta i&nbsp;staramy&nbsp;się dostarczać niestandardowe rozwiązania, które spełniają ich&nbsp;specyficzne wymagania. Niezależnie od&nbsp;tego, czy&nbsp;potrzebujesz tymczasowego, czy&nbsp;stałego magazynu, mamy wszystko pod&nbsp;kontrolą. Możesz na&nbsp;nas polegać, że zajmiemy&nbsp;się Twoimi oponami i&nbsp;felgami z&nbsp;najwyższą starannością i&nbsp;profesjonalizmem. Dbamy o&nbsp;Twoje opony, myjemy je i&nbsp;przechowujemy poprawnie, ponieważ wiemy, jak ważne jest to&nbsp;dla ich&nbsp;trwałości.</p></div>
<div class="col-md-8 margin-top-xl-lg-md margin-top-sm margin-top-xs brr-md-img shadow-img-1 margin-bottom-sm margin-bottom-xl-lg-md margin-bottom-xs"><p><img class="" src="/images/design/content-przechowywanie-opon.webp" alt="przechowywanie opon" width="800" height="533"></p></div>
</div>
<div class="row"></div>
<div class="row"><div class="col-md-12"><h3>Dlaczego tak&nbsp;ważne jest właściwe przechowywanie opon?</h3></div></div>
<div class="row"><div class="col-md-12"><p>Opony w&nbsp;samochodzie są jednymi z&nbsp;najważniejszych elementów pojazdu. To&nbsp;właśnie one&nbsp;zapewniają bezpieczeństwo na&nbsp;drodze, dlatego tak&nbsp;ważne jest, aby o&nbsp;nie&nbsp;dbać i&nbsp;odpowiednio je konserwować. Jeśli nie&nbsp;masz miejsca do&nbsp;przechowywania opon, skorzystaj z&nbsp;naszych usług. Zapraszamy!</p></div></div>',50,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('uslugi-elektryka-samochodowego','service','Usługi elektryka samochodowego','Usługi elektryka samochodowego','Usługi elektryka samochodowego – Soft Car Service',null,'/images/design/banner.webp','',60,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('profesjonalna-konserwacja-podwozia','service','Profesjonalna konserwacja podwozia','Profesjonalna konserwacja podwozia','Profesjonalna konserwacja podwozia - Soft Car Service',null,'/images/design/banner.webp','<div class="row"><div class="col-md-12"><h1>Profesjonalna konserwacja podwozia</h1></div></div>
<div class="row">
<div class="well-2 margin-top-xl-lg-md margin-top-sm margin-top-xs col-md-8">
<p><strong>Profesjonalna konserwacja podwozia i&nbsp;profili zamkniętych – skuteczna ochrona przed korozją</strong></p>
<p>Podwozie samochodu to&nbsp;jeden z&nbsp;najbardziej narażonych na&nbsp;uszkodzenia i&nbsp;korozję elementów pojazdu. Wilgoć, sól drogowa, piasek oraz&nbsp;kamienie codziennie oddziałują na&nbsp;metalowe części, przyspieszając proces rdzewienia. Szczególnie w&nbsp;Polsce, gdzie zimowe warunki są wymagające, odpowiednia konserwacja podwozia to&nbsp;klucz do&nbsp;utrzymania auta w&nbsp;dobrym stanie technicznym na&nbsp;długie lata.</p>
<p>W naszym serwisie oferujemy kompleksową konserwację zarówno podwozia, jak i&nbsp;profili zamkniętych, które często są pomijane, a&nbsp;jednocześnie to&nbsp;w&nbsp;nich najczęściej gromadzi&nbsp;się wilgoć i&nbsp;zanieczyszczenia, prowadząc do&nbsp;niewidocznej korozji od&nbsp;wewnątrz. Stosujemy wyłącznie sprawdzone, wysokiej jakości preparaty antykorozyjne, zapewniające długotrwałą ochronę przed rdzą.</p>
<h2>Kiedy warto wykonać konserwację podwozia?</h2>
<p>Regularna ochrona antykorozyjna jest kluczowa, ale&nbsp;kiedy najlepiej przeprowadzić konserwację podwozia samochodu?</p>
<p>1. Nowe samochody – warto zabezpieczyć auto już w&nbsp;pierwszych latach eksploatacji, ponieważ oryginalna warstwa ochronna może być niewystarczająca.<br>2. Samochody kilkuletnie – w&nbsp;autach 3 - 5-letnich pojawiają&nbsp;się pierwsze oznaki korozji, dlatego ich&nbsp;konserwacja jest niezbędna do&nbsp;uniknięcia poważniejszych uszkodzeń.<br>3. Samochody używane intensywnie – jeśli auto często porusza&nbsp;się po&nbsp;błotnistych drogach, terenach o&nbsp;dużej wilgotności lub&nbsp;jest narażone na&nbsp;kontakt z&nbsp;solą zimową, warto konserwować podwozie co 2-3 lata.<br>4. Po&nbsp;naprawach blacharskich – jeśli pojazd przeszedł prace lakiernicze lub&nbsp;blacharskie, dodatkowa ochrona pomoże zapobiec ponownej korozji.</p>
<h3>Dlaczego konserwacja podwozia jest tak&nbsp;ważna?</h3>
<p>Brak odpowiedniego zabezpieczenia podwozia może prowadzić do&nbsp;poważnych problemów:<br>Osłabienie konstrukcji pojazdu – rdza może doprowadzić do&nbsp;perforacji podwozia i&nbsp;uszkodzenia elementów nośnych.<br>Wzrost kosztów napraw – usuwanie korozji i&nbsp;wymiana skorodowanych części jest znacznie droższa niż profilaktyczna konserwacja.<br>Spadek wartości pojazdu – auta z&nbsp;oznakami korozji tracą na&nbsp;wartości rynkowej i&nbsp;są trudniejsze do&nbsp;sprzedaży.<br>Problemy z&nbsp;przeglądem technicznym – w&nbsp;niektórych przypadkach poważna korozja może uniemożliwić przejście badania technicznego.</p>
<p>Odpowiednia konserwacja profili zamkniętych jest równie istotna. Te niewidoczne przestrzenie w&nbsp;progach, podłużnicach i&nbsp;belkach są szczególnie podatne na&nbsp;rdzę, ponieważ gromadzą wilgoć, błoto i&nbsp;sól. W&nbsp;naszym serwisie stosujemy specjalne preparaty, które wnikają do&nbsp;wnętrza profili, skutecznie zabezpieczając je na&nbsp;długi czas.</p>
</div>
<div class="col-md-4"><p><video controls="controls" width="auto" height="100%">
<source src="/images/design/VID-20241218-WA0009.mp4" type="video/mp4"></video></p></div>
</div>
<div class="row"><div class="col-md-8">
<h3>&nbsp;</h3>
<h3>Jak przebiega konserwacja podwozia?</h3>
<p>W naszym serwisie stosujemy profesjonalne i&nbsp;sprawdzone metody ochrony antykorozyjnej. Proces konserwacji składa&nbsp;się z&nbsp;kilku etapów:</p>
<p>1. Dokładne mycie podwozia – usuwamy wszelkie zabrudzenia, błoto i&nbsp;resztki soli drogowej.<br>2. Oczyszczenie powierzchni – mechaniczne usunięcie luźnej rdzy oraz&nbsp;ewentualne szlifowanie miejsc, gdzie zaczyna&nbsp;się korozja.<br>3. Aplikacja preparatów antykorozyjnych – stosujemy wysokiej jakości środki zabezpieczające, które wnikają w&nbsp;strukturę metalu i&nbsp;tworzą trwałą powłokę ochronną.<br>4. Konserwacja profili zamkniętych – wtryskujemy specjalne preparaty do&nbsp;wnętrza progów, podłużnic i&nbsp;innych zamkniętych elementów konstrukcyjnych.<br>5. Utrwalenie warstwy ochronnej – pozostawiamy pojazd na&nbsp;odpowiedni czas, aby środki dobrze wyschły i&nbsp;zapewniły maksymalną skuteczność.</p>
<h3>Dlaczego warto wybrać nasz&nbsp;serwis?</h3>
<p>Używamy tylko&nbsp;sprawdzonych, markowych preparatów, które zapewniają długotrwałą ochronę przed korozją.<br>Mamy doświadczenie w&nbsp;konserwacji różnych typów pojazdów – od&nbsp;aut osobowych po&nbsp;dostawcze.<br>Dokładnie przygotowujemy powierzchnię przed nałożeniem warstwy ochronnej, co gwarantuje jej&nbsp;skuteczność.<br>Zapewniamy konkurencyjne ceny i&nbsp;profesjonalne podejście do&nbsp;każdego klienta.</p>
<p>Zadbaj o&nbsp;swoje auto i&nbsp;przedłuż jego&nbsp;żywotność! Umów&nbsp;się na&nbsp;profesjonalną konserwację podwozia i&nbsp;profili zamkniętych w&nbsp;naszym serwisie już dziś!</p>
<p>&nbsp;</p>
</div></div>
<div class="row"></div>',70,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('ustawianie-geometrii-i-zbieznosci-kol','service','Ustawianie geometrii i zbieżności kół','Ustawianie geometrii i zbieżności kół','Ustawianie geometrii i zbieżności kół - Oferta serwisu','Profesjonalne ustawianie geometrii i zbieżności kół w naszym serwisie. Zapewniamy dokładne i precyzyjne usługi, które poprawią bezpieczeństwo oraz komfort jazdy. Skorzystaj z naszej oferty i zadbaj o swoje auto.','/images/design/banner.webp','<div class="row"><div class="col-md-12"><h1>Ustawianie geometrii i&nbsp;zbieżności kół</h1></div></div>
<div class="row">
<div class="well-2 margin-top-xl-lg-md margin-top-sm margin-top-xs col-md-6">
<p><strong>Ustawienie geometrii i&nbsp;zbieżności kół</strong>&nbsp;- oto nowa usługa, którą wprowadzamy w&nbsp;naszym serwisie!<br> <br>Terminowe <strong>ustawienie geometrii i&nbsp;zbieżności kół</strong> jest kluczem do:</p>
<ul>
<li>zachowania sterowności i&nbsp;maksymalnej stabilności pojazdu po&nbsp;jego&nbsp;długotrwałej eksploatacji;</li>
<li>bezpieczeństwa podczas jazdy po&nbsp;każdej drodze;</li>
<li>utrzymania dobrego stanu opon i&nbsp;zapobiegania ich&nbsp;przedwczesnemu zużyciu.</li>
</ul>
<p><br>📐Prawidłowo ustawione kąty zbieżności kół mają bezpośredni wpływ na&nbsp;zachowanie samochodu na&nbsp;drodze, zużycie opon, zużycie paliwa oraz&nbsp;komfort i&nbsp;bezpieczeństwo kierowcy i&nbsp;pasażerów.<br>Specjaliści 🚗Soft Car Service zdiagnozują i&nbsp;wyregulują ustawienie pochylenia kół na&nbsp;Twoim samochodzie.</p>
<p><a class="animated bounceIn btn btn-default border-radius-sm btn-shadow" href="tel:+48739533830">739 533 830<br></a><br><br>ul. Legionów 124<br>Czechowice-Dziedzice</p>
<p>&nbsp;</p>
</div>
<div class="margin-top-xl-lg-md margin-top-sm margin-top-xs brr-md-img shadow-img-1 margin-bottom-sm margin-bottom-xl-lg-md margin-bottom-xs col-md-6"><p><a href="/images/design/naprawa-sterownika.webp" class="vbox-item"><img style="float: left;" src="/images/design/content-geometria-i-zbieznosc-kol.webp" alt="naprawa zbieżności kół" width="600" height="503"></a></p></div>
</div>
<div class="row"></div>',80,true);
insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values ('auto-zastepcze','service','Auto zastępcze','Auto zastępcze dostępne w naszym serwisie samochodowym','Auto zastępcze na czas naprawy | Soft Car Service','Auto zastępcze na czas naprawy w Soft Car Service. Zachowaj mobilność, gdy Twój samochód jest w serwisie. Jasne warunki i minimum formalności.','/images/design/banner.webp','<div class="row"><div class="col-md-12"><h1>Auto zastępcze dostępne w&nbsp;naszym serwisie samochodowym</h1></div></div>
<div class="row"><div class="col-md-12">
<p><img style="float: right;" src="/images/design/content-auto-zastepcze.webp" alt="kluczyki do&nbsp;samochodu" width="550" height="359">Podczas gdy Twoje auto jest w&nbsp;naprawie, <strong>nie musisz rezygnować z&nbsp;codziennej mobilności. </strong>W naszym serwisie samochodowym oferujemy usługę <strong>auto zastępcze na&nbsp;czas naprawy</strong>, stworzoną z&nbsp;myślą o&nbsp;wygodzie naszych klientów.</p>
<h3>Samochód zastępczy na&nbsp;czas naprawy</h3>
<p>Wiemy, jak ważne jest posiadanie auta na&nbsp;co dzień. Dlatego udostępniamy <strong>samochód zastępczy</strong>, dzięki któremu możesz bez&nbsp;przeszkód realizować swoje plany, gdy Twoje auto znajduje&nbsp;się w&nbsp;naszym warsztacie.<br>Komfort w&nbsp;przystępnej formie</p>
<p>Usługa <strong>auto zastępcze w&nbsp;naszym serwisie</strong> jest dostępna na&nbsp;<strong>jasnych i&nbsp;przyjaznych warunkach</strong>, tak&nbsp;aby była realnym wsparciem w&nbsp;codziennym życiu. Koszt korzystania z&nbsp;auta zastępczego jest <strong>symboliczny w&nbsp;porównaniu do&nbsp;wygody, jaką zyskujesz,</strong> a&nbsp;szczegóły ustalane są indywidualnie przy przyjęciu auta do&nbsp;naprawy.</p>
<h2>
<br>Kiedy dostępne jest auto zastępcze?</h2>
<ul>
<li>podczas napraw mechanicznych</li>
<li>w trakcie dłuższego serwisu</li>
<li>przy diagnostyce wymagającej więcej czasu</li>
</ul>
<h3>Jak skorzystać z&nbsp;auta zastępczego?</h3>
<ol>
<li>Umów&nbsp;się na&nbsp;naprawę samochodu</li>
<li>Poinformuj nas o&nbsp;potrzebie <strong>auta zastępczego</strong>
</li>
<li>Odbierz samochód na&nbsp;czas trwania naprawy</li>
</ol>
<h3>Dlaczego warto wybrać nasz&nbsp;serwis?</h3>
<p>Oferujemy kompleksowe usługi, nowoczesne podejście i&nbsp;<strong>auto zastępcze na&nbsp;czas naprawy</strong> w&nbsp;przystępnej formie. Dbamy o&nbsp;to, aby serwis był wygodny, uczciwy i&nbsp;dostosowany do&nbsp;potrzeb klienta.</p>
<p>&nbsp;</p>
</div></div>',90,true);

insert into public.slides(image,kicker,title,body_html,button_label,button_href,sort,is_published) values ('/images/slider-h-4.webp',null,null,'<div class="row" disabled=""><div class="col-md-12 text-center" disabled="">
<p class="mininaglowek">Oferta</p>
<hr class="hr-zmienny-2">
<p class="heading3">Geometria i&nbsp;ustawianie zbieżności kół</p>
<p class="heading4">Bezpieczeństwo podczas jazdy&nbsp;<span class="font-color-2" disabled="">•</span>&nbsp;Zachowanie sterowności i&nbsp;maksymalnej stabilności pojazdu</p>
<p class="heading4">&nbsp;</p>
<p>W naszej ofercie znajdziesz między innymi usługę ustawienia geometrii i&nbsp;zbieżności kół, które zapewnią prawidłowe zużycie opon, paliwa oraz&nbsp;bezpieczeństwa jazdy.</p>
</div></div>
<div class="button-wrapper-slide  text-center" style="display: block;"><a class="btn border-radius-sm btn-shadow" href="/oferta/ustawianie-geometrii-i-zbieznosci-kol" target="_self" tabindex="0">Zobacz ofertę</a></div>','Zobacz ofertę','/oferta/ustawianie-geometrii-i-zbieznosci-kol',10,true);
insert into public.slides(image,kicker,title,body_html,button_label,button_href,sort,is_published) values ('/images/slider-h-2-6.webp',null,null,'<div class="row"><div class="col-md-12 text-center">
<p class="mininaglowek">Oferta</p>
<hr class="hr-zmienny-2">
<p class="heading3">Serwis klimatyzacji samochodowej</p>
<p class="heading4">Sprawdzenie szczelności&nbsp;<span class="font-color-2">•</span>&nbsp;Uzupełnianie czynnika chłodniczego <span class="font-color-2">•</span>&nbsp;Czyszczenie układu</p>
<p>Nowa usługa w&nbsp;naszym warsztacie</p>
</div></div>
<div class="button-wrapper-slide  text-center" style="display: block;"><a class="btn border-radius-sm btn-shadow" href="/oferta/serwis-klimatyzacji-samochodowej" target="_self" tabindex="-1">Zobacz ofertę</a></div>','Zobacz ofertę','/oferta/serwis-klimatyzacji-samochodowej',20,true);
insert into public.slides(image,kicker,title,body_html,button_label,button_href,sort,is_published) values ('/images/slider-h-2-6-2.webp',null,null,'<div class="row"><div class="col-md-12 text-center">
<p class="mininaglowek">O nas</p>
<hr class="hr-zmienny-2">
<p class="heading3">Profesjonalna konserwacja podwozia</p>
<p class="heading3">&nbsp;</p>
<p>Soft Car Service to&nbsp;profesjonalny serwis samochodowy, który oferuje szeroki zakres usług, od&nbsp;przeglądów technicznych po&nbsp;skomplikowane naprawy mechaniczne.</p>
</div></div>
<div class="button-wrapper-slide  text-center" style="display: block;"><a class="btn border-radius-sm btn-shadow" href="/oferta/profesjonalna-konserwacja-podwozia" target="_self" tabindex="-1">Zobacz ofertę</a></div>','Zobacz ofertę','/oferta/profesjonalna-konserwacja-podwozia',30,true);

insert into public.info_boxes(title,body_html,image,image_side,sort,is_published) values (null,'<div class="row"><div class="col-md-12"><p class="text-stylekmlrh5jn" style="text-align: center;">Zadbaj o&nbsp;swoje auto z&nbsp;naszą profesjonalną usługą ustawiania geometrii i&nbsp;zbieżności kół. Popraw bezpieczeństwo i&nbsp;komfort jazdy już dziś. Sprawdź naszą ofertę!</p></div></div>','https://softcarservice.pl/images/geometria-kol.jpg','right',10,true);
insert into public.info_boxes(title,body_html,image,image_side,sort,is_published) values (null,'<div class="row"><div class="col-md-12">
<p class="text-stylekmlrh5jn"><a href="/oferta/auto-zastepcze"><strong>Wprowadzamy nową usługę - auto zastępcze na&nbsp;czas naprawy</strong></a></p>
<p><a href="/oferta/auto-zastepcze"><img class="pull-right img-toRight" style="float: right;" src="/images/design/usluga-samochodu-zastepczego.webp" alt="Usługa auta zastępczego" width="600" height="400"></a></p>
<p>Gdy Twoje auto jest w&nbsp;naszym serwisie, nie&nbsp;zostajesz bez&nbsp;środka transportu. Oferujemy <strong><a href="/oferta/auto-zastepcze">samochód zastępczy na&nbsp;czas naprawy,</a> </strong>dzięki któremu możesz swobodnie realizować codzienne obowiązki.</p>
<p>Usługa dostępna jest na&nbsp;<strong>jasnych i&nbsp;przystępnych warunkach, </strong>a szczegóły ustalamy indywidualnie przy przyjęciu auta. Komfort, wygoda i&nbsp;minimum formalności – wszystko po&nbsp;to, abyś nie&nbsp;tracił mobilności.</p>
<p>☎️Zapraszamy:&nbsp;<a href="tel:+48739533830">739 533 830</a><br>📍ul. Legionów 124<br>Czechowice-Dziedzice</p>
</div></div>',null,'none',20,true);
insert into public.info_boxes(title,body_html,image,image_side,sort,is_published) values (null,'<div class="row"><div class="col-md-12">
<p class="text-stylekmlrh5jn">Wprowadzamy nową usługę w&nbsp;naszym serwisie nabijanie klimatyzacji samochodowej</p>
<p><img class="pull-right img-toRight" src="/images/design/nabijanie-klimatyzacji.jpg" alt="Nabijanie klimatyzacji" width="450" height="450">📯Uwaga! Nowa usługa w&nbsp;Soft Car Service 👨‍🔧! Na&nbsp;życzenie klientów, a&nbsp;także w&nbsp;celu rozszerzenia i&nbsp;podniesienia jakości usług, informujemy, że od&nbsp;dziś w&nbsp;naszym serwisie samochodowym przeprowadzamy -</p>
<p>🌬 Napełnianie klimatyzacji samochodowej ❄️</p>
<p>☀️Lato tuż tuż, więc&nbsp;czas sprawdzić sprawność klimatyzacji i&nbsp;oczywiście uzupełnić ją czynnikiem🌊.</p>
<p>💙Ten rodzaj usługi przeznaczony jest zarówno dla klientów prywatnych, jak i&nbsp;przedstawicieli firm posiadających floty samochodowe.🚗</p>
<p>&nbsp;</p>
<p>🦸‍♂️Od teraz zapewniamy kompleksowy serwis klimatyzacji samochodowej, który obejmuje:<br>&nbsp; 🔹sprawdzenie szczelności;<br>&nbsp; 🔹uzupełnianie czynnika chłodniczego w&nbsp;klimatyzacji samochodowej;<br>&nbsp; 🔹czyszczenie układu z&nbsp;grzybów, pleśni, śmieci i&nbsp;innych zanieczyszczeń.</p>
<p>&nbsp;</p>
<p>☎️Na wizytę można umówić&nbsp;się telefonicznie: <a href="tel:+48739533830">739 533 830</a><br>lub udać&nbsp;się do&nbsp;naszego warsztatu: 📍ul. Legionów 124<br>Czechowice-Dziedzice</p>
</div></div>',null,'none',30,true);

insert into public.usp_items(icon,label,sort) values ('/images/design/icon-usp-1.webp','Wykwalifikowani pracownicy',10);
insert into public.usp_items(icon,label,sort) values ('/images/design/icon-usp-2.webp','Dokładność i precyzja',20);
insert into public.usp_items(icon,label,sort) values ('/images/design/icon-usp-3.webp','Terminowość',30);
insert into public.usp_items(icon,label,sort) values ('/images/design/icon-usp-4.webp','Szeroka oferta',40);
insert into public.counters(value,label,sort) values (10,'lat doświadczenia mechaników',10);
insert into public.counters(value,label,sort) values (3000,'zrealizowanych zleceń',20);
insert into public.counters(value,label,sort) values (3000,'zadowolonych klientów',30);
insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values ('/images/design/box-offer-l.webp','Naprawa silinika','Mechanika oraz diagnostyka samochodowa','/oferta/mechanika-oraz-diagnostyka-samochodowa',10,true);
insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values ('/images/design/box-offer-l-1.webp','Układ hamulcowy','Naprawy układu hamulcowego','/oferta/naprawy-ukladu-hamulcowego',20,true);
insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values ('/images/design/box-offer-l-klimatyzacja.webp','Serwis klimatyzacji samochodowej','Serwis klimatyzacji samochodowej','/oferta/serwis-klimatyzacji-samochodowej',30,true);
insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values ('/images/design/box-offer-l-przechowywanie-opon.webp','Sezonowe przechowywanie opon','Sezonowe przechowywanie opon','/oferta/sezonowe-przechowywanie-opon',40,true);
insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values ('/images/design/box-offer-auto-zastepcze.webp','Oferta samochodu zastępczego','Auto zastępcze','/oferta/auto-zastepcze',50,true);
insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values ('/images/design/box-offer-l-naprawa-zawieszenia-i-silnikow.webp','Naprawa zawieszenia','Naprawa zawieszenia i silników','/oferta/naprawa-zawieszenia-i-silnikow',60,true);
insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values ('/images/design/box-offer-l-1-1.webp','Wulkanizacja','Wulkanizacja i wymiana opon','/oferta/sezonowe-przechowywanie-opon',70,true);
insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values ('/images/box-offer-l-1-1-1-1.webp','Usługi elektryka samochodowego','Usługi elektryka samochodowego','/oferta/uslugi-elektryka-samochodowego',80,true);
insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values ('/images/design/box-offer-l-ustawianie-zbieznosci-kol.webp','Ustawianie geometrii i zbieżności kół','Ustawianie geometrii i zbieżności kół','/oferta/ustawianie-geometrii-i-zbieznosci-kol',90,true);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-1.webp','Soft Car Service — zdjęcie 1',10);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-2.webp','Soft Car Service — zdjęcie 2',20);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-3.webp','Soft Car Service — zdjęcie 3',30);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-4.webp','Soft Car Service — zdjęcie 4',40);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-5.webp','Soft Car Service — zdjęcie 5',50);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-6.webp','Soft Car Service — zdjęcie 6',60);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-7.webp','Soft Car Service — zdjęcie 7',70);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-8.webp','Soft Car Service — zdjęcie 8',80);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-9.webp','Soft Car Service — zdjęcie 9',90);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-10.webp','Soft Car Service — zdjęcie 10',100);
insert into public.gallery_images(url,alt,sort) values ('/images/galerie/35/softcar-11.webp','Soft Car Service — zdjęcie 11',110);

insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Wstęp','<div class="row" disabled=""><div class="col-md-12" disabled=""><h1>Cennik usług - Soft Car Service</h1></div></div>
<div class="row" disabled="">
<div class="col-md-6" disabled="">
<p>Soft Car Service to&nbsp;profesjonalny <strong>serwis samochodowy </strong>specjalizujący&nbsp;się w&nbsp;kompleksowej obsłudze pojazdów. Oferujemy szeroki zakres usług z&nbsp;obszaru <strong>mechaniki pojazdowej, </strong>w tym przeglądy techniczne, <strong>diagnostykę komputerową,</strong> naprawy układu hamulcowego oraz&nbsp;inne naprawy eksploatacyjne.</p>
<p>Naszym priorytetem jest wysoka jakość usług, transparentne zasady współpracy oraz&nbsp;uczciwe podejście do&nbsp;każdego klienta. Ceny usług są jasno określone i&nbsp;ustalane indywidualnie w&nbsp;zależności od&nbsp;modelu pojazdu oraz&nbsp;stopnia skomplikowania naprawy.</p>','[]'::jsonb,0,true);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Cennik robocizny','<ul>
<li>
<strong>180&nbsp;zł brutto / godzina</strong> – samochody osobowe</li>
<li>
<strong>220&nbsp;zł brutto / godzina </strong>– samochody dostawcze, busy.</li>
</ul>
<p>Każde zlecenie wyceniamy indywidualnie po&nbsp;wstępnej diagnostyce lub&nbsp;konsultacji, aby zapewnić możliwie najbardziej precyzyjny koszt naprawy.</p>
<p>W Soft Car Service naprawiamy samochody wszystkich marek i&nbsp;dajemy gwarancję na&nbsp;wykonane prace oraz&nbsp;zakupione u&nbsp;nas części.&nbsp;<br><br></p>
<p>Skontaktuj&nbsp;się z&nbsp;nami pod&nbsp;numerem tel. <a href="tel:739533830">739 533 830</a> lub&nbsp;mailowo:&nbsp;<a href="mailto:office.softcarservice@gmail.com">office.softcarservice@gmail.com</a>.</p>
<p>&nbsp;</p>
</div>
<div class="margin-bottom-sm margin-bottom-xs col-md-6" disabled=""><p style="text-align: center;" disabled=""><img class="" src="/images/design/content-cennik.webp" alt="Podawanie karty" width="770" height="500" disabled=""></p></div>
</div>
<div class="row"><div class="col-md-12">','[]'::jsonb,10,true) returning id)
select 1 from s;
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Informacja dla klientów','<p>Po zakończeniu naprawy pojazdu klient zostanie powiadomiony SMS-em o&nbsp;gotowości auta do&nbsp;odbioru.</p>
<p>W przypadku, gdy klient&nbsp;<strong>nie odbierze pojazdu w&nbsp;ciągu 2 dni od&nbsp;wysłania SMS-a,</strong> automatycznie zostanie naliczona opłata za&nbsp;przechowanie pojazdu w&nbsp;wysokości <strong>30&nbsp;zł za&nbsp;każdą rozpoczętą dobę.</strong></p>
<p>Prosimy o&nbsp;terminowy odbiór pojazdu, aby uniknąć dodatkowych kosztów.<br><br></p>

<p>&nbsp;</p>
</div></div>
<div class="row"><div class="col-md-12">
<p>&nbsp;</p>','[]'::jsonb,20,true) returning id)
select 1 from s;
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Ważna informacja dla klientów','<p>W przypadku, gdy przyjeżdżają Państwo na&nbsp;usługę lub&nbsp;naprawę z&nbsp;własnymi częściami, do&nbsp;ceny wykonanej usługi zostanie doliczona opłata w&nbsp;wysokości <strong>20% wartości robocizny.</strong></p>
<p>Informujemy również, że na&nbsp;części dostarczone przez klienta <strong>nie udzielamy gwarancji.</strong></p>
<p>Dziękujemy za&nbsp;zrozumienie!<br><br></p>

<p>&nbsp;</p>
</div></div>
<div class="row"><div class="col-md-8">','[]'::jsonb,30,true) returning id)
select 1 from s;
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Opony 2025','<p>* zadzwoń pod&nbsp;numer telefonu i&nbsp;dowiedz&nbsp;się więcej&nbsp;</p>
</div></div>
<div class="row" disabled=""></div>
<div class="row" disabled=""><div class="col-md-12" disabled=""></div></div>
<div class="row" disabled=""><div class="col-md-12" disabled=""></div></div>
<div class="row">
<div class="col-md-5">','["Usługa", "Cena", "&nbsp;", "&nbsp;", "&nbsp;"]'::jsonb,40,true) returning id)
insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values
  ('["Naprawa opony łatka", "80 zł", "&nbsp;", "&nbsp;", "&nbsp;"]'::jsonb,10),
  ('["Naprawa opony sznurek", "40 zł", "&nbsp;", "&nbsp;", "&nbsp;"]'::jsonb,20),
  ('["Wymiana opon stal+wyważenie do", "do R16", "160 zł", "Czujniki + 20 zł", "Bus + 20%"]'::jsonb,30),
  ('["&nbsp;", "do R17", "180 zł", "Czujniki + 20 zł", "Bus + 20%"]'::jsonb,40),
  ('["Wymiana opon alusy+wyważenie do", "do R16", "180 zł", "Czujniki + 20 zł", "Bus + 20%"]'::jsonb,50),
  ('["&nbsp;", "od R17", "200 zł", "Czujniki + 20 zł", "Bus + 20%"]'::jsonb,60),
  ('["&nbsp;", "od R19", "230 zł", "Czujniki + 20 zł", "Bus + 20%"]'::jsonb,70),
  ('["Wyważenie", "35 zł/szt.", "&nbsp;", "&nbsp;", "&nbsp;"]'::jsonb,80),
  ('["Wyważenie bez&nbsp;montażu felgi stalowe/felgi aluminiowe", "zadzwoń i&nbsp;zapytaj o&nbsp;szczegóły *", "&nbsp;", "&nbsp;", "&nbsp;"]'::jsonb,90),
  ('["Przechowywanie opon i&nbsp;felg przez cały sezon&nbsp;", "120 zł/kpl.", "&nbsp;", "&nbsp;", "&nbsp;"]'::jsonb,100),
  ('["Pozostawienie opon do&nbsp;utylizacji – komplet", "15 zł/szt", "&nbsp;", "&nbsp;", "&nbsp;"]'::jsonb,110),
  ('["Worki na&nbsp;opony", "4 zł/szt. (zakup 1,5 zł)", "&nbsp;", "&nbsp;", "&nbsp;"]'::jsonb,120)
) as v(cells,sort);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Olej 2025','','["Usługa", "Zastosowanie", "Cena", "&nbsp;"]'::jsonb,50,true) returning id)
insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values
  ('["&nbsp;", "Olej + filtr oleju", "150 zł", "&nbsp;"]'::jsonb,10),
  ('["Wymiana oleju silnika", "Olej + wszyst. filtry", "200 zł", "benzyna"]'::jsonb,20),
  ('["&nbsp;", "Olej + wszyst. filtry", "250 zł", "diesel"]'::jsonb,30)
) as v(cells,sort);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('&nbsp;','','["Usługa", "Cena"]'::jsonb,60,true) returning id)
insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values
  ('["Wymiana oleju skrzynia manual", "od 120 zł"]'::jsonb,10),
  ('["Wymiana oleju skrzynia automat (stat.)", "od 180 zł"]'::jsonb,20),
  ('["Wymiana płynu hamulcowego", "200 zł"]'::jsonb,30),
  ('["Wymiana płynu chłodniczego", "150 zł"]'::jsonb,40),
  ('["Roboczogodzina", "180 zł"]'::jsonb,50),
  ('["Roboczogodzina (samochody osobowo-dostawcze, dostawcze)", "200 zł"]'::jsonb,60)
) as v(cells,sort);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('&nbsp;','','[]'::jsonb,70,true) returning id)
select 1 from s;
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Konserwacja','</div>
<div class="col-md-5 col-md-offset-2">','["Usługa", "Cena"]'::jsonb,80,true) returning id)
insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values
  ('["Wycena konserwacji (w przypadku, gdy klient nie&nbsp;będzie robić u&nbsp;nas)", "100 zł"]'::jsonb,10),
  ('["Konserwacja podstawowa", "od 1000 zł"]'::jsonb,20),
  ('["Konserwacja pełna", "od 2000 zł"]'::jsonb,30)
) as v(cells,sort);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Układ hamulcowy','</div>
</div>
<div class="row" disabled=""><div class="col-md-12" disabled=""></div></div>
<div class="row">
<div class="col-md-5">','["Usługa", "Cena"]'::jsonb,90,true) returning id)
insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values
  ('["Wymiana klocków hamulcowych 1 oś", "od 170 zł"]'::jsonb,10),
  ('["Wymiana tarcz i&nbsp;klocków 1 oś", "od 250 zł"]'::jsonb,20),
  ('["Wymiana płynu hamulcowego", "od 200 zł"]'::jsonb,30),
  ('["Wymiana linki ręcznego", "od 270 zł"]'::jsonb,40),
  ('["Wymiana zacisku tył", "od 180 zł"]'::jsonb,50),
  ('["Wymiana zacisku przód", "od 200 zł"]'::jsonb,60),
  ('["Konserwacja zacisku", "od 350 zł"]'::jsonb,70),
  ('["Wymiana pompy ABS", "od 400 zł"]'::jsonb,80),
  ('["Wymiana przewodu elastycznego", "od 80 zł"]'::jsonb,90),
  ('["Wymiana przewodu miedziany", "od 150 zł"]'::jsonb,100),
  ('["Wymiana szczęk hamulcowych", "od 100&nbsp;zł"]'::jsonb,110)
) as v(cells,sort);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Zawieszenie','</div>
<div class="col-md-5 col-md-offset-2">','["Usługa", "Cena"]'::jsonb,100,true) returning id)
insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values
  ('["Geometria", "200/300 (z osi)"]'::jsonb,10),
  ('["Wymiana", "&nbsp;"]'::jsonb,20),
  ('["półoś (simering)", "od 300 do&nbsp;500 zł"]'::jsonb,30),
  ('["przegub (osłona)", "od 250 do&nbsp;450 zł"]'::jsonb,40),
  ('["Wymiana amortyzatora oś tylna", "od 150&nbsp;zł do&nbsp;350 (1 szt.)"]'::jsonb,50),
  ('["Wymiana amortyzatora przód - sprężyny, poduszki", "od 250 do&nbsp;400 (1 szt.)"]'::jsonb,60),
  ('["Wymiana łożyska koła przód", "od 300 zł"]'::jsonb,70),
  ('["Wymiana łożyska koła tył", "od 250 zł"]'::jsonb,80),
  ('["Wymiana łożyska ze zwrotnicą", "od 150 zł"]'::jsonb,90),
  ('["Wymiana końcówki drążka kierowniczego", "od 120 zł"]'::jsonb,100),
  ('["Wymiana drążka kierowniczego", "od 150 zł/szt."]'::jsonb,110),
  ('["Wymiana sworznia wahacza", "od 150 zł/szt."]'::jsonb,120),
  ('["Wymiana tulei wahacza 1 szt", "&nbsp;od&nbsp;300 zł"]'::jsonb,130),
  ('["Wymiana wahacza", "&nbsp;od&nbsp;200 zł"]'::jsonb,140),
  ('["Wymiana łączników stabilizatora (guma stabilizatora)", "&nbsp;od&nbsp;120 zł/szt."]'::jsonb,150),
  ('["Wymiana przekładni kierowniczej (maglownicy)", "&nbsp;od&nbsp;300 zł"]'::jsonb,160),
  ('["Wymiana belki oś tylna", "&nbsp;od&nbsp;750 zł"]'::jsonb,170),
  ('["Wymiana poduszki silnika", "od 150 do&nbsp;550 zł"]'::jsonb,180),
  ('["Wymiana tuleji belki (cukierka)", "od 150 do&nbsp;350 zł"]'::jsonb,190),
  ('["Wymiana poduszki belki", "od 150 zł"]'::jsonb,200),
  ('["Wymiana tłumika środkowego lub&nbsp;końcówki", "&nbsp;od&nbsp;200 zł"]'::jsonb,210)
) as v(cells,sort);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Silnik i&nbsp;skrzynia','</div>
</div>
<div class="row" disabled=""><div class="col-md-12" disabled=""></div></div>
<div class="row">
<div class="col-md-5">','["Usługa", "Cena"]'::jsonb,110,true) returning id)
insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values
  ('["Wymiana sprzęgła", "od 1080 zł"]'::jsonb,10),
  ('["Wymiana paska napędu osprzętu", "od 120 zł"]'::jsonb,20),
  ('["Wymiana rozrządu (pasek)", "od 1250 zł"]'::jsonb,30),
  ('["Wymiana rozrządu (łańcuch)", "od 1450 zł"]'::jsonb,40),
  ('["Wymiana sondy", "od 150 do&nbsp;400 zł"]'::jsonb,50),
  ('["Wymiana pasku napędu", "od 120 zł"]'::jsonb,60),
  ('["Wymiana uszczelki pokrywy zaworów", "od 250 zł"]'::jsonb,70),
  ('["Wymiana uszczelki głowicy", "od 1500 zł"]'::jsonb,80),
  ('["Wymiana uszczelki miski", "od 250 zł"]'::jsonb,90),
  ('["Wymiana świec zapłonowych", "&nbsp;od&nbsp;30 zł/szt."]'::jsonb,100),
  ('["Wymiana świec żarowych", "&nbsp;od&nbsp;50 zł/szt."]'::jsonb,110),
  ('["Wymiana wtryskiwacza diesel", "&nbsp;od&nbsp;60 zł/szt."]'::jsonb,120),
  ('["Wymiana wtryskiwacza diesel + kodowanie", "od 100 zł"]'::jsonb,130),
  ('["Wymiana wtrysku benzyna", "od 120 zł"]'::jsonb,140),
  ('["Wymiana alternatora/rozrusznika", "od 250 zł"]'::jsonb,150),
  ('["Wymiana pompy wspomagania", "od 400 zł"]'::jsonb,160),
  ('["Wymiana chłodnicy wody", "od 400 zł"]'::jsonb,170),
  ('["Wymiana turbo", "od 550 zł"]'::jsonb,180),
  ('["Wymiana pompy paliwa (w zbiorn.)", "&nbsp;od&nbsp;200 zł"]'::jsonb,190),
  ('["Wymiana pompy paliwa wysokiego ciśnienia", "&nbsp;od&nbsp;500 zł"]'::jsonb,200),
  ('["Wymiana linki sprzęgła", "&nbsp;od&nbsp;250 zł"]'::jsonb,210)
) as v(cells,sort);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Diagnostyka samochodowa','</div>
<div class="col-md-5 col-md-offset-2">','["Usługa", "Cena"]'::jsonb,120,true) returning id)
insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values
  ('["Diagnostyka komputerowa &nbsp;(kasowanie, odczyt błędów) &nbsp; &nbsp;", "150 zł"]'::jsonb,10),
  ('["Przegląd techniczny", "220 zł"]'::jsonb,20),
  ('["Diagnostyka zawieszenia", "od 150 zł"]'::jsonb,30),
  ('["Diagnostyka przed zakupem auta (+komputer)", "500 zł"]'::jsonb,40)
) as v(cells,sort);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('Pełny serwis klimatyzacji z&nbsp;odgrzybianiem (ozonowanie)','</div>
</div>
<div class="row" disabled=""><div class="col-md-12" disabled=""></div></div>
<div class="row"><div class="col-md-12">','["Usługa", "Cena"]'::jsonb,130,true) returning id)
insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values
  ('["Usługa", "155 zł"]'::jsonb,10),
  ('["100&nbsp;g czynnika chłodniczego R134a", "40zł"]'::jsonb,20)
) as v(cells,sort);
with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values ('WARUNKI GWARANCJI USŁUG SERWISOWYCH','<p>Dbając o&nbsp;przejrzystość zasad oraz&nbsp;komfort naszych Klientów, poniżej przedstawiamy warunki gwarancji na&nbsp;usługi wykonywane w&nbsp;naszym serwisie.</p>
<p><strong>1. Zakres i&nbsp;czas trwania gwarancji</strong></p>
<p>Serwis udziela gwarancji na&nbsp;wykonaną usługę na&nbsp;okres 5 miesięcy lub&nbsp;5 000 km, w&nbsp;zależności od&nbsp;tego, co nastąpi wcześniej.<br>Gwarancja obejmuje prawidłowość wykonania usługi zgodnie z&nbsp;zasadami sztuki serwisowej.</p>
<p><br><strong>2. Gwarancja na&nbsp;części zamienne</strong></p>
<p>Gwarancja na&nbsp;części zamienne udzielana jest przez producenta lub&nbsp;dostawcę części, zgodnie z&nbsp;jego&nbsp;indywidualnymi warunkami gwarancyjnymi.<br>Serwis nie&nbsp;jest producentem części i&nbsp;nie&nbsp;decyduje o&nbsp;uznaniu lub&nbsp;odrzuceniu reklamacji części przez producenta.<br><br></p>
<p><strong>3. Procedura reklamacyjna</strong></p>
<p>Każda reklamacja wymaga:</p>
<ul>
<li>wcześniejszego zgłoszenia w&nbsp;serwisie,</li>
<li>przeprowadzenia ponownej diagnostyki pojazdu w&nbsp;celu ustalenia przyczyny usterki.</li>
</ul>
<p>Zgłoszenie reklamacji nie&nbsp;oznacza jej&nbsp;automatycznego uznania.<br><br></p>
<p><strong>4. Podejrzenie wady fabrycznej części</strong></p>
<p>W przypadku podejrzenia wady fabrycznej części:</p>
<ul>
<li>koszt demontażu reklamowanej części,</li>
<li>koszt montażu części zamiennej,</li>
<li>koszt nowej części ponosi Klient do&nbsp;momentu otrzymania oficjalnej decyzji producenta lub&nbsp;dostawcy części.</li>
</ul>
<p>&nbsp;</p>
<p><strong>5. Decyzja producenta</strong></p>
<p>W przypadku uznania reklamacji przez producenta lub&nbsp;dostawcę części:</p>
<p>Klient otrzymuje zwrot kosztów lub&nbsp;wymianę części zgodnie z&nbsp;warunkami gwarancji producenta,<br>koszty robocizny podlegają zwrotowi wyłącznie wtedy, gdy producent wyraźnie je obejmuje.</p>
<p>W przypadku nieuznania reklamacji przez producenta lub&nbsp;dostawcę części, wszystkie poniesione koszty pozostają po&nbsp;stronie Klienta.<br><br></p>
<p><strong>6. Wyłączenia gwarancji</strong></p>
<p>Gwarancja nie&nbsp;obejmuje:</p>
<ul>
<li>naturalnego zużycia eksploatacyjnego części,</li>
<li>uszkodzeń powstałych w&nbsp;wyniku dalszej jazdy mimo występowania usterki,</li>
<li>uszkodzeń wynikających z&nbsp;niewłaściwej eksploatacji pojazdu,</li>
<li>ingerencji osób trzecich lub&nbsp;innych serwisów,</li>
<li>usterek niezwiązanych bezpośrednio z&nbsp;wcześniej wykonaną usługą.</li>
</ul>
<p>&nbsp;</p>
<p><strong>7. Postanowienia końcowe</strong></p>
<p>Niniejsze warunki gwarancji nie&nbsp;wyłączają ani&nbsp;nie&nbsp;ograniczają uprawnień konsumenta wynikających z&nbsp;obowiązujących przepisów prawa, w&nbsp;szczególności z&nbsp;tytułu rękojmi.</p>
<p>&nbsp;</p>

<p>&nbsp;</p>
</div></div>','[]'::jsonb,140,true) returning id)
select 1 from s;

insert into public.legacy_users(id,name,username,email,group_name,register_date,last_visit,blocked) values
(135,'Super User','kierownik','noreply@wenet.pl','Super Users','2016-11-09 14:40:28','2026-09-07 10:20:02',false),
(908,'testuser','testuser','noreply@csgroup.pl','Manager','2022-10-21 14:57:19',null,false),
(909,'Jacek Moczydłowski','jmoczydlowski','jmoczydlowski@wenet.pl','Registered','2022-10-26 13:31:12','2022-11-02 12:41:59',false),
(910,'Ewa Bukowska','ebukowska','ebukowska@wenet.pl','Registered','2022-11-09 10:40:21','2023-01-12 09:40:57',false),
(911,'Sylwia Grzegorzewska','sgrzegorzewska','sgrzegorzewska@wenet.pl','Registered','2022-11-16 11:01:29','2022-12-16 12:27:48',false),
(912,'Marta Grajewska','mgrajewska','mgrajewska@wenet.pl','Registered','2022-11-16 11:01:36','2022-12-16 13:01:54',false),
(913,'Radek Chłus','rchlus','rchlus@wenet.pl','Registered','2022-11-16 11:01:45','2023-01-11 07:46:42',false),
(914,'Karolina Romanowska','kromanowska','kromanowska@wenet.pl','Registered','2022-11-16 11:02:12','2023-01-10 14:13:22',false),
(915,'Ewelina Matuszak','ematuszak','ematuszak@wenet.pl','Registered','2022-11-16 11:02:24','2023-01-19 11:49:37',false),
(916,'Agata Błaszkiewicz','ablaszkiewicz','ablaszkiewicz@wenet.pl','Registered','2022-11-16 11:02:50','2022-12-19 07:55:56',false),
(917,'Anna Popławska','apoplawska','apoplawska@wenet.pl','Registered','2022-11-16 11:03:08','2022-12-19 07:53:06',false),
(918,'Wojciech Zabielski','wzabielski','wzabielski@wenet.pl','Registered','2022-11-16 11:03:22','2023-02-22 07:37:00',false),
(919,'Marta Klimuszko','mklimuszko','mklimuszko@wenet.pl','Registered','2022-11-16 11:03:26','2022-12-16 12:22:57',false),
(920,'Aneta Garlicka','agarlicka','agarlicka@wenet.pl','Registered','2022-11-16 11:03:46','2022-12-16 13:12:15',false),
(921,'Paulina Sieńczuk','psienczuk','psienczuk@wenet.pl','Registered','2022-11-16 11:04:04','2023-01-11 07:52:48',false),
(922,'Aleksandra Bychowska','abychowska','abychowska@wenet.pl','Registered','2022-11-16 11:04:39','2023-01-14 21:49:01',false),
(923,'Paulina Wycichowska','pwycichowska','pwycichowska@wenet.pl','Registered','2022-11-16 11:05:38','2022-12-19 13:27:16',false),
(924,'Magdalena Borowska','maborowska','maborowska@wenet.pl','Registered','2022-11-16 11:05:50','2023-01-11 10:15:28',false),
(925,'Paulina Szewczul-Danik','pszewczul','pdanik@wenet.pl','Registered','2022-11-16 11:06:34','2023-01-11 06:58:02',false),
(926,'Patrycja Ostrowska','postrowska','postrowska@wenet.pl','Registered','2022-11-16 11:06:56','2023-01-16 11:39:01',false),
(927,'Paulina Kościukiewicz','pkosciukiewicz','pkosciukiewicz@wenet.pl','Registered','2022-11-16 11:07:36','2023-01-11 07:15:51',false),
(928,'Andrzej Paradziński','aparadzinski','aparadzinski@wenet.pl','Registered','2022-11-16 11:11:44',null,false),
(929,'Julia Kalitowska','jkalitowska','jkalitowska@wenet.pl','Registered','2022-11-16 11:43:43','2023-01-11 07:53:01',false),
(930,'Anna Czuchan','aczuchan','aczuchan@wenet.pl','Registered','2022-11-16 12:39:20','2023-01-09 08:52:31',false),
(931,'Natalia Kondracka','nkondracka','nkondracka@wenet.pl','Registered','2022-11-16 14:38:41','2023-05-11 13:36:11',false),
(932,'Gabriela Fyda','gfyda','gfyda@wenet.pl','Registered','2022-11-16 14:38:54','2022-12-16 12:26:29',true),
(933,'Dominika Glapa','dglapa','dglapa@wenet.pl','Registered','2022-11-16 14:39:07','2023-01-11 07:13:05',true),
(934,'Julia Krause','jkrause','jkrause@wenet.pl','Registered','2022-11-16 14:40:32','2023-03-14 11:16:53',false),
(935,'Agnieszka Zgiep','azgiep','azgiep@wenet.pl','Registered','2022-11-16 14:41:11','2023-01-11 09:36:26',false),
(936,'Marzena Milhausen','mmilhausen','mmilhausen@wenet.pl','Registered','2022-11-16 14:42:01','2023-01-11 07:38:57',false),
(937,'Mateusz Dąbkowski','mdabkowski','mdabkowski@wenet.pl','Registered','2022-11-16 14:55:54','2023-01-10 13:54:29',false),
(938,'Łukasz Biernacki','lbiernacki','lbiernacki@wenet.pl','Registered','2022-11-16 14:56:32','2023-01-10 11:03:46',false),
(939,'Grażyna Strumik','gstrumik','gstrumik@wenet.pl','Registered','2022-11-16 15:06:33','2023-01-13 07:13:58',false),
(940,'Aleksandra Wiśniewska','alwisniewska','alwisniewska@wenet.pl','Registered','2022-11-17 07:42:30','2023-01-10 11:36:00',false),
(941,'Natalia Sochoń','nsochon','nsochon@wenet.pl','Registered','2022-11-17 07:49:20','2023-01-11 08:14:16',false),
(942,'Anna Tabaczyk','atabaczyk','atabaczyk@wenet.pl','Registered','2022-11-17 08:10:35','2023-01-11 07:55:20',false),
(943,'Julia Świtkowska','jswitkowska','jswitkowska@wenet.pl','Registered','2022-11-17 08:11:01','2023-01-12 14:32:10',false),
(944,'Kinga Sławińska','kslawinska','kslawinska@wenet.pl','Registered','2022-11-17 08:12:41','2022-12-16 12:53:02',false),
(945,'Aleksandra Bogucka','abogucka','abogucka@wenet.pl','Registered','2022-11-17 08:13:11','2022-12-16 12:55:04',false),
(946,'Magdalena Sośnicka','msosnicka','msosnicka@wenet.pl','Registered','2022-11-17 08:14:39','2023-01-11 07:56:36',false),
(947,'Katarzyna Szefke','kszefke','kszefke@wenet.pl','Registered','2022-11-17 08:18:49','2023-01-11 10:40:16',false),
(948,'Jacek Barton','jbarton','jbarton@wenet.pl','Registered','2022-11-17 13:29:14','2023-01-11 10:11:25',false),
(949,'Piotr Trypus','ptrypus','ptrypus@wenet.pl','Registered','2022-11-18 07:49:41','2022-12-16 13:42:48',true),
(950,'Brunon Podlacha','bpodlacha','bpodlacha@wenet.pl','Registered','2022-11-21 07:28:56','2023-03-15 10:13:45',true),
(951,'Izabela Więckowska','iwieckowska','iwieckowska@wenet.pl','Registered','2022-12-09 07:24:51','2023-01-25 14:28:38',false),
(952,'Dorota Kościółek','dkosciolek','dkosciolek@wenet.pl','Registered','2022-12-09 07:39:51','2023-01-05 11:15:23',false),
(953,'Michał Kargulewicz','mkargulewicz','mkargulewicz@wenet.pl','Registered','2022-12-09 07:51:33','2023-01-13 07:13:06',false),
(954,'Szymon Jabłoński','sjablonski','sjablonski@wenet.pl','Registered','2022-12-12 10:22:28','2023-04-19 13:12:32',false),
(955,'Marcin Grześ','mgrzes','mgrzes@wenet.pl','Registered','2022-12-12 11:40:28','2023-02-22 12:46:40',false),
(956,'Ewa Skibinska','eskibinska','eskibinska@wenet.pl','Registered','2022-12-12 11:45:13','2022-12-12 11:49:45',false),
(957,'Tamara Danielczyk','tdanielczyk','tdanielczyk@wenet.pl','Registered','2022-12-16 12:31:59','2022-12-16 12:32:32',false),
(958,'Maciej Biłda','mbilda','mbilda@wenet.pl','Registered','2022-12-16 12:36:54','2022-12-16 12:51:03',false),
(959,'Ewa Garlicka','egarlicka','egarlicka@wenet.pl','Registered','2022-12-16 14:05:01','2022-12-16 14:05:29',false),
(960,'Joanna Palliardi','jpalliardi','jpalliardi@wenet.pl','Registered','2022-12-22 09:34:57','2022-12-22 09:36:58',false),
(961,'Monika Krautwald','mkrautwald','mkrautwald@wenet.pl','Registered','2022-12-29 19:53:19','2022-12-29 19:54:08',false),
(962,'Weronika Turkowiak','wturkowiak','wturkowiak@wenet.pl','Registered','2023-01-02 14:28:21','2023-02-01 13:17:48',false),
(963,'Jagoda Mirowska','jmirowska','jmirowska@wenet.pl','Registered','2023-01-04 09:08:57',null,true),
(964,'Katarzyna Kowalczyk','kkowalczyk','kkowalczyk@wenet.pl','Registered','2023-01-09 08:55:55','2023-01-09 08:56:14',false),
(965,'Artur Lis','arlis','arlis@wenet.pl','Registered','2023-01-09 08:56:28','2023-06-15 08:06:12',false),
(966,'Szymon Krukowski','skrukowski','skrukowski@wenet.pl','Registered','2023-01-09 10:02:37','2023-01-09 10:02:52',false),
(967,'Agata Zagalska','azagalska','azagalska@wenet.pl','Registered','2023-01-09 10:04:53','2023-01-09 10:05:12',false),
(968,'Katarzyna Szwaj','kszwaj','kszwaj@wenet.pl','Registered','2023-01-09 10:05:45','2023-01-09 10:06:46',false),
(969,'natalia natkaniec','nnatkaniec','nnatkaniec@wenet.pl','Registered','2023-01-09 10:07:55','2023-01-09 10:08:13',false),
(970,'Marzena Langa','mlanga','mlanga@wenet.pl','Registered','2023-01-09 10:09:38',null,true),
(971,'Papuga Łukasz','lpapuga','lpapuga@wenet.pl','Registered','2023-01-10 13:55:46','2023-01-10 13:56:02',false),
(972,'Iwona Opoka','iopoka','iopoka@wenet.pl','Registered','2023-01-10 13:56:02','2023-01-10 13:59:49',false),
(973,'Patrycja Kuliszewska','pasikora','pasikora@wenet.pl','Registered','2023-01-10 22:01:23','2023-01-10 22:03:45',false),
(974,'Artur Maciejewski','amaciejewski','amaciejewski@wenet.pl','Registered','2023-01-11 07:03:34','2023-01-11 07:18:39',false),
(975,'Michał Banas','mibanas','mibanas@wenet.pl','Registered','2023-01-11 07:07:27','2023-01-11 07:21:41',false),
(976,'Radosław Skalski','rskalski','rskalski@wenet.pl','Registered','2023-01-11 07:21:01','2023-04-20 12:42:30',false),
(977,'igluszak','igluszak','igluszak@wenet.pl','Registered','2023-01-11 14:59:46','2023-01-11 15:00:12',false),
(978,'Norbert Rycaj','nrycaj','nrycaj@wenet.pl','Registered','2023-01-12 07:22:06','2023-01-12 07:22:37',false),
(979,'Cezary Gondek','cgondek','cgondek@wenet.pl','Registered','2023-01-12 07:37:03','2023-01-13 11:14:00',false),
(980,'mmarciniak','mmarciniak','mmarciniak@wenet.pl','Registered','2023-01-12 07:37:40','2023-01-12 07:38:23',false),
(981,'Angelika Niemira','aniemira','aniemira@wenet.pl','Registered','2023-01-12 07:38:30','2023-01-12 07:39:36',false),
(982,'Kamil Bednarczyk','kbednarczyk','kbednarczyk@wenet.pl','Registered','2023-01-12 07:38:38','2023-01-12 08:17:16',false),
(983,'Joanna Domanik','jdomanik','jdomanik@wenet.pl','Registered','2023-01-31 11:55:56','2023-01-31 11:56:33',false),
(984,'Wioleta Witczak','wwitczak','wwitczak@wenet.pl','Registered','2023-02-24 07:55:26','2023-04-27 08:10:03',false),
(985,'Bartosz Owsianko','bowsianko','bowsianko@wenet.pl','Registered','2023-04-13 10:45:24','2023-04-13 11:39:44',false),
(986,'Mariusz Zamiejski','mzamiejski','mzamiejski@wenet.pl','Registered','2023-07-28 13:08:08','2023-07-28 13:28:06',false),
(987,'kroplazdrowiapl@gmail.com','kroplazdrowiapl@gmail.com','catch@i-host.pl','Super Users','2026-09-07 10:20:59',null,false);

commit;