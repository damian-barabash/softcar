#!/usr/bin/env python3
"""Buduje seed SQL dla Supabase z tresci pobranej ze starej strony."""
import json, re, sys, os, html

SCR = os.environ.get('SCR', '/private/tmp/claude-501/-Users-dmytrii-Desktop-PROJEKTY-SOFTCAR/c97d551d-dc54-47ae-a014-ce15fe4b03e2/scratchpad')
home = json.load(open(f'{SCR}/content/home.json', encoding='utf8'))
pages = json.load(open(f'{SCR}/content/pages.json', encoding='utf8'))

# ---- mapowanie starych, martwych linkow na nowe strony ----
LINKMAP = {
    '/component/blankcomponent/?view=default&Itemid=962': '/oferta/naprawy-ukladu-hamulcowego',
    '/component/blankcomponent/?view=default&Itemid=1263': '/oferta/uslugi-elektryka-samochodowego',
}

def clean_html(s):
    if not s:
        return ''
    s = s.replace('https://softcarservice.pl', '')
    s = re.sub(r'#joomlaImage://[^"\'\s]*', '', s)
    # joomla-hidden-mail -> zwykly mailto
    def mail(m):
        blob = m.group(0)
        first = re.search(r'is-mail="1"[^>]*first="([^"]*)"[^>]*last="([^"]*)"', blob)
        if not first:
            first = re.search(r'first="([^"]*)"[\s\S]*?last="([^"]*)"', blob)
        if first:
            import base64
            try:
                a = base64.b64decode(first.group(1)).decode()
                b = base64.b64decode(first.group(2)).decode()
                addr = f'{a}@{b}'
                return f'<a href="mailto:{addr}">{addr}</a>'
            except Exception:
                pass
        txt = re.sub(r'<[^>]+>', '', blob).strip()
        return f'<a href="mailto:{txt}">{txt}</a>' if '@' in txt else txt
    s = re.sub(r'<joomla-hidden-mail[\s\S]*?</joomla-hidden-mail>', mail, s)
    for old, new in LINKMAP.items():
        s = s.replace(old, new).replace(html.escape(old), new)
    s = re.sub(r'\s+(data-[a-z-]+|loading|decoding)="[^"]*"', '', s)
    s = re.sub(r'<div class="clearfix"></div>', '', s)
    return s.strip()

def q(v):
    if v is None:
        return 'null'
    if isinstance(v, bool):
        return 'true' if v else 'false'
    if isinstance(v, (int, float)):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"

def jq(v):
    return "'" + json.dumps(v, ensure_ascii=False).replace("'", "''") + "'::jsonb"

def text_of(h):
    return re.sub(r'\s+', ' ', re.sub(r'<[^>]+>', ' ', h or '')).strip()

out = []
W = out.append
W("-- SEED wygenerowany automatycznie (scripts/build-seed.py). Nie edytowac recznie.\n")
W("begin;")
for t in ['price_rows', 'price_sections', 'gallery_images', 'offer_tiles', 'counters', 'usp_items',
          'info_boxes', 'slides', 'pages', 'menu_items', 'settings', 'legacy_users']:
    W(f"delete from public.{t};")
W("")

# ------------------------------------------------------------------ settings
SET = {
 'company':      {'name': 'Soft Car Service', 'street': 'ul. Legionów 124', 'zip': '43-502',
                  'city': 'Czechowice-Dziedzice', 'phone': '+48 739 533 830',
                  'phone_href': 'tel:+48739533830', 'email': 'office.softcarservice@gmail.com',
                  'hours': '8.00 - 23.00',
                  'map_lat': 49.8978624, 'map_lng': 19.0099803,
                  'route_url': 'https://www.google.com/maps/dir/?api=1&destination=49.8978624,19.0099803'},
 'social':       [{'label': 'Facebook',  'href': 'https://www.facebook.com/softcarservice/',                  'icon': '/images/design/icon-facebook.svg'},
                  {'label': 'Instagram', 'href': 'https://instagram.com/softcarservice?igshid=MzRlODBiNWFlZA==','icon': '/images/design/icon-instagram.webp'},
                  {'label': 'TikTok',    'href': 'https://www.tiktok.com/@softcarservice',                     'icon': '/images/design/tiktok-icon-circle-3.webp'},
                  {'label': 'Google Maps','href': 'https://maps.app.goo.gl/vG1nH4xTRNGixdfe7',                 'icon': '/images/gmaps.webp'}],
 'branding':     {'logo': '/images/design/logo.webp', 'favicon': '/images/design/favicon.ico',
                  'og_image': '/images/design/logo-soft-car-service.png', 'banner': '/images/design/banner.webp'},
 'header_cta':   [{'label': 'WYZNACZ TRASĘ', 'href': 'https://www.google.com/maps/dir/?api=1&destination=49.8978624,19.0099803', 'style': 'ghost'},
                  {'label': 'Zadzwoń', 'href': 'tel:+48739533830', 'style': 'solid'}],
 'home_about':   {'html': clean_html(home['about']['html']), 'cta_html': clean_html(home['about']['cta'])},
 'home_usp':     {'heading_html': clean_html(home['uspHeading'])},
 'home_marquee': {'text': (home.get('marquee') or '')[:120].strip()},
 'home_counters':{'heading_html': clean_html(home['countersHeading'])},
 'home_parallax':{'heading_html': clean_html(home['parallax']['heading']),
                  'body_html': clean_html(home['parallax']['body']),
                  'button': home['parallax']['button']},
 'home_offer':   {'heading_html': clean_html(home['offerHeading'])},
 'footer':       {'copyright_html': '<p>Wszelkie prawa zastrzeżone © {year} Soft Car Service</p>',
                  'legal_links': [{'label': 'Polityka prywatności', 'href': '/polityka-prywatnosci'},
                                  {'label': 'Polityka Cookies', 'href': '/polityka-cookies'}]},
 'seo':          {'title': home['meta']['title'], 'description': home['meta']['desc'],
                  'site_name': 'Soft Car Service', 'locale': 'pl_PL'},
 'contact_form': {'to': 'office.softcarservice@gmail.com',
                  'subject': 'Nowa wiadomość ze strony softcar.pl',
                  'success': 'Dziękujemy! Wiadomość została wysłana.',
                  'rodo': 'Wyrażam zgodę na przetwarzanie moich danych osobowych w celu odpowiedzi na zapytanie.'},
}
GROUPS = {'company': 'kontakt', 'social': 'kontakt', 'contact_form': 'kontakt',
          'branding': 'ogolne', 'seo': 'ogolne', 'footer': 'ogolne', 'header_cta': 'ogolne'}
LABELS = {'company': 'Dane firmy', 'social': 'Social media', 'branding': 'Logo i favicon',
          'header_cta': 'Przyciski w nagłówku', 'home_about': 'Strona główna — O nas',
          'home_usp': 'Strona główna — USP', 'home_marquee': 'Strona główna — pasek przewijany',
          'home_counters': 'Strona główna — liczniki', 'home_parallax': 'Strona główna — paralaksa',
          'home_offer': 'Strona główna — nagłówek oferty', 'footer': 'Stopka', 'seo': 'SEO',
          'contact_form': 'Formularz kontaktowy'}
for k, v in SET.items():
    W(f"insert into public.settings(key,value,group_name,label) values "
      f"({q(k)},{jq(v)},{q(GROUPS.get(k,'strona-glowna'))},{q(LABELS.get(k,k))});")
W("")

# ------------------------------------------------------------------ menu
SERVICES = [
    ('mechanika-oraz-diagnostyka-samochodowa', 'Mechanika oraz diagnostyka samochodowa'),
    ('naprawy-ukladu-hamulcowego',             'Naprawy układu hamulcowego'),
    ('naprawa-zawieszenia-i-silnikow',         'Naprawa zawieszenia i silników'),
    ('serwis-klimatyzacji-samochodowej',       'Serwis klimatyzacji samochodowej'),
    ('sezonowe-przechowywanie-opon',           'Sezonowe przechowywanie opon'),
    ('uslugi-elektryka-samochodowego',         'Usługi elektryka samochodowego'),
    ('profesjonalna-konserwacja-podwozia',     'Profesjonalna konserwacja podwozia'),
    ('ustawianie-geometrii-i-zbieznosci-kol',  'Ustawianie geometrii i zbieżności kół'),
    ('auto-zastepcze',                         'Auto zastępcze'),
]
W("with h as (")
W("  insert into public.menu_items(location,label,href,sort) values")
W("    ('header','Strona główna','/',10),('header','O nas','/o-nas',20),('header','Oferta','/oferta',30),")
W("    ('header','Cennik','/cennik',40),('header','Kontakt','/kontakt',50)")
W("  returning id,label)")
W("insert into public.menu_items(location,parent_id,label,href,sort)")
W("select 'header',(select id from h where label='Oferta'),v.label,v.href,v.sort from (values")
W(",\n".join(f"  ({q(t)},{q('/oferta/'+s)},{(i+1)*10})" for i, (s, t) in enumerate(SERVICES)))
W(") as v(label,href,sort);")
for i, (label, href) in enumerate([('Strona główna', '/'), ('O nas', '/o-nas'), ('Oferta', '/oferta'),
                                   ('Cennik', '/cennik'), ('Kontakt', '/kontakt')]):
    W(f"insert into public.menu_items(location,label,href,sort) values ('footer',{q(label)},{q(href)},{(i+1)*10});")
W("")

# ------------------------------------------------------------------ pages
BANNERS = {
 'o-nas': '/images/design/banner.webp', 'oferta': '/images/design/content-oferta.webp',
 'cennik': '/images/design/content-cennik.webp', 'kontakt': '/images/design/banner.webp',
}
PAGEDEF = [
 ('o-nas',  'page',  'O nas'),
 ('oferta', 'page',  'Oferta'),
 ('cennik', 'page',  'Cennik'),
 ('kontakt','page',  'Kontakt'),
 ('polityka-prywatnosci',  'legal', 'Polityka prywatności'),
 ('polityka-cookies',      'legal', 'Polityka Cookies'),
 ('obowiazek-informacyjny','legal', 'Obowiązek informacyjny'),
]
for slug, kind, title in PAGEDEF:
    p = pages[slug]
    W(f"insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values "
      f"({q(slug)},{q(kind)},{q(title)},{q(p.get('h1'))},{q(p['title'])},{q(p.get('desc'))},"
      f"{q(BANNERS.get(slug,'/images/design/banner.webp'))},{q(clean_html(p['bodyHtml']))},0,true);")
for i, (slug, title) in enumerate(SERVICES):
    p = pages.get(slug)
    if p:
        body, h1, mt, md = clean_html(p['bodyHtml']), p.get('h1'), p['title'], p.get('desc')
    else:  # strony, ktore w starym serwisie prowadzily donikad (404) — tresc z bazy Joomli
        body, h1, mt, md = '', title, f'{title} – Soft Car Service', None
    W(f"insert into public.pages(slug,kind,title,h1,meta_title,meta_desc,banner_image,body_html,sort,is_published) values "
      f"({q(slug)},'service',{q(title)},{q(h1)},{q(mt)},{q(md)},'/images/design/banner.webp',{q(body)},{(i+1)*10},true);")
W("")

# ------------------------------------------------------------------ slides
for i, s in enumerate(home['slides']):
    img = re.sub(r'#joomlaImage.*$', '', s['img'] or '')
    h = clean_html(s['html'])
    kicker = None
    m = re.search(r'<p[^>]*class="[^"]*minintro[^"]*"[^>]*>(.*?)</p>', h, re.S)
    if m:
        kicker = text_of(m.group(1))
        h = h.replace(m.group(0), '')
    tm = re.search(r'<(h[12])[^>]*>(.*?)</\1>', h, re.S)
    title = text_of(tm.group(2)) if tm else None
    if tm:
        h = h.replace(tm.group(0), '')
    btn = s['button'] or {}
    W(f"insert into public.slides(image,kicker,title,body_html,button_label,button_href,sort,is_published) values "
      f"({q(img)},{q(kicker)},{q(title)},{q(h.strip())},{q(btn.get('label'))},{q(btn.get('href'))},{(i+1)*10},true);")
W("")

# ------------------------------------------------------------------ info boxes
for i, b in enumerate(home['infoBoxes']):
    h = clean_html(b['html'])
    tm = re.search(r'<(h[1-4])[^>]*>(.*?)</\1>', h, re.S)
    title = text_of(tm.group(2)) if tm else None
    if tm:
        h = h.replace(tm.group(0), '')
    img = re.sub(r'#joomlaImage.*$', '', b['img'] or '') or None
    W(f"insert into public.info_boxes(title,body_html,image,image_side,sort,is_published) values "
      f"({q(title)},{q(h.strip())},{q(img)},{q('right' if img else 'none')},{(i+1)*10},true);")
W("")

# ------------------------------------------------------------------ usp / counters / offer / gallery
for i, u in enumerate(home['usp']):
    W(f"insert into public.usp_items(icon,label,sort) values ({q(u['img'])},{q(u['label'])},{(i+1)*10});")
for i, (val, lab) in enumerate([(10, 'lat doświadczenia mechaników'), (3000, 'zrealizowanych zleceń'), (3000, 'zadowolonych klientów')]):
    W(f"insert into public.counters(value,label,sort) values ({val},{q(lab)},{(i+1)*10});")
for i, o in enumerate(home['offer']):
    img = re.sub(r'#joomlaImage.*$', '', (o['img'] or '')).replace('https://softcarservice.pl', '')
    href = LINKMAP.get(o['href'], o['href'])
    W(f"insert into public.offer_tiles(image,image_alt,title,href,sort,is_published) values "
      f"({q(img)},{q(o['alt'])},{q(o['title'])},{q(href)},{(i+1)*10},true);")
for i in range(1, 12):
    W(f"insert into public.gallery_images(url,alt,sort) values "
      f"('/images/galerie/35/softcar-{i}.webp','Soft Car Service — zdjęcie {i}',{i*10});")
W("")

# ------------------------------------------------------------------ cennik
body = clean_html(pages['cennik']['bodyHtml'])
parts = re.split(r'(?=<h[23][^>]*>)', body)
intro = parts[0]
sec = 0
W(f"insert into public.price_sections(title,intro_html,columns,sort,is_published) values "
  f"({q('Wstęp')},{q(intro.strip())},{jq([])},0,true);")
for chunk in parts[1:]:
    m = re.match(r'<(h[23])[^>]*>(.*?)</\1>', chunk, re.S)
    if not m:
        continue
    title = text_of(m.group(2))
    rest = chunk[m.end():]
    tbl = re.search(r'<table[\s\S]*?</table>', rest)
    cols, rows = [], []
    if tbl:
        trs = re.findall(r'<tr[\s\S]*?</tr>', tbl.group(0))
        if trs:
            first = [text_of(c) for c in re.findall(r'<t[hd][^>]*>([\s\S]*?)</t[hd]>', trs[0])]
            first = [c for c in first if c and c != '\xa0']
            cols = first or ['Usługa', 'Cena']
            for tr in trs[1:]:
                cells = [text_of(c) for c in re.findall(r'<t[hd][^>]*>([\s\S]*?)</t[hd]>', tr)]
                cells = [c for c in cells if c and c != '\xa0']
                if cells:
                    rows.append(cells)
        rest = rest.replace(tbl.group(0), '')
    rest = re.sub(r'<hr[^>]*>', '', rest).strip()
    if not title and not rows and not text_of(rest):
        continue
    sec += 1
    W(f"with s as (insert into public.price_sections(title,intro_html,columns,sort,is_published) values "
      f"({q(title)},{q(rest)},{jq(cols)},{sec*10},true) returning id)")
    if rows:
        W("insert into public.price_rows(section_id,cells,sort) select s.id,v.cells,v.sort from s, (values")
        W(",\n".join(f"  ({jq(r)},{(j+1)*10})" for j, r in enumerate(rows)))
        W(") as v(cells,sort);")
    else:
        W("select 1 from s;")
W("")

# ------------------------------------------------------------------ legacy users
sys.path.insert(0, SCR)
from parse import cols as jcols, rows as jrows
c = jcols('nr7je5_users'); r = jrows('nr7je5_users'); ix = {n: c.index(n) for n in c}
gtitle = {x[0]: x[4] for x in jrows('nr7je5_usergroups')}
gmap = {}
for x in jrows('nr7je5_user_usergroup_map'):
    gmap[x[0]] = gtitle.get(x[1], x[1])
vals = []
for row in r:
    def d(v):
        return None if v in ('NULL', '', '0000-00-00 00:00:00') else v
    vals.append(f"({row[ix['id']]},{q(row[ix['name']])},{q(row[ix['username']])},{q(row[ix['email']])},"
                f"{q(gmap.get(row[ix['id']]))},{q(d(row[ix['registerDate']]))},{q(d(row[ix['lastvisitDate']]))},"
                f"{q(row[ix['block']] == '1')})")
W("insert into public.legacy_users(id,name,username,email,group_name,register_date,last_visit,blocked) values")
W(",\n".join(vals) + ";")
W("")
W("commit;")

open('/Users/dmytrii/Desktop/PROJEKTY/SOFTCAR/softcar/supabase/migrations/0002_seed.sql', 'w', encoding='utf8').write("\n".join(out))
print("seed lines:", len(out))
