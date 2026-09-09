#!/usr/bin/env python3
"""Rozbija surowy HTML sekcji strony glownej na pola strukturalne w tabeli settings."""
import json, re, os

SCR = os.environ.get('SCR', '/private/tmp/claude-501/-Users-dmytrii-Desktop-PROJEKTY-SOFTCAR/c97d551d-dc54-47ae-a014-ce15fe4b03e2/scratchpad')
home = json.load(open(f'{SCR}/content/home.json', encoding='utf8'))

def clean(s):
    s = (s or '').replace('https://softcarservice.pl', '')
    s = re.sub(r'#joomlaImage://[^"\'\s]*', '', s)
    s = re.sub(r'<div class="clearfix"></div>', '', s)
    return re.sub(r'\n\s*\n', '\n', s).strip()

def grab(html, pattern, flags=re.S):
    m = re.search(pattern, html, flags)
    return (m.group(1).strip() if m else None), (html.replace(m.group(0), '') if m else html)

# ---------- O nas ----------
a = clean(home['about']['html'])
kicker, a = grab(a, r'<p class="mininaglowek">(.*?)</p>')
a = re.sub(r'<hr class="hr-zmienny-2">', '', a)
heading, a = grab(a, r'<h1[^>]*>(.*?)</h1>')
well, a = grab(a, r'(<div class="well[^"]*">[\s\S]*?</div>)')
cta_title, well2 = grab(well or '', r'<p class="text-stylekmlrhjv6">(.*?)</p>')
cta_btn = re.search(r'<a class="btn[^"]*" href="([^"]*)"[^>]*>(.*?)</a>', well or '', re.S)
cta_body = re.sub(r'<a class="btn[\s\S]*?</a>', '', well2 or '')
cta_body = re.sub(r'<p class="text-stylekmlrhjv6">[\s\S]*?</p>|<hr[^>]*>|</?div[^>]*>|<p>\s*</p>', '', cta_body).strip()
body = re.sub(r'</?div[^>]*>', '', a)
body = re.sub(r'\n{2,}', '\n', body).strip()

about = {'kicker': kicker, 'heading': heading, 'body_html': body,
         'cta': {'title': cta_title,
                 'body_html': cta_body,
                 'button_label': cta_btn.group(2).strip() if cta_btn else None,
                 'button_href': cta_btn.group(1) if cta_btn else None}}

# ---------- USP ----------
usp_head, _ = grab(clean(home['uspHeading']), r'<p class="mininaglowek">(.*?)</p>')
usp = {'kicker': usp_head}

# ---------- liczniki ----------
ch = clean(home['countersHeading'])
c_kicker, ch = grab(ch, r'<p class="mininaglowek">(.*?)</p>')
c_head, ch = grab(ch, r'<h2[^>]*>(.*?)</h2>')
c_body, _ = grab(ch, r'(<p>[\s\S]*?</p>)')
counters = {'kicker': c_kicker, 'heading': c_head, 'body_html': c_body}

# ---------- paralaksa ----------
ph = clean(home['parallax']['heading'])
p_head, _ = grab(ph, r'<h2[^>]*>(.*?)</h2>') if '<h2' in ph else grab(ph, r'<p[^>]*>(.*?)</p>')
pb = re.sub(r'</?div[^>]*>', '', clean(home['parallax']['body'])).strip()
parallax = {'heading': p_head or re.sub(r'<[^>]+>', '', ph).strip(), 'body_html': pb,
            'button': home['parallax']['button']}

# ---------- oferta ----------
oh = clean(home['offerHeading'])
o_kicker, oh = grab(oh, r'<p class="mininaglowek">(.*?)</p>')
o_head, _ = grab(oh, r'<h2[^>]*>(.*?)</h2>')
if not o_head:
    o_head, _ = grab(oh, r'<p[^>]*>(.*?)</p>')
offer = {'kicker': o_kicker, 'heading': o_head}

# ---------- alty ikon USP ----------
alts = re.findall(r'<img src="(/images/design/icon-usp-\d\.webp)" alt="([^"]*)"', clean(home['uspHeading']) + open(f'{SCR}/live/index.html', encoding='utf8').read())

def sq(v):
    return "'" + json.dumps(v, ensure_ascii=False).replace("'", "''") + "'::jsonb"

sql = [
    f"update public.settings set value={sq(about)}, label='Strona główna — sekcja O nas' where key='home_about';",
    f"update public.settings set value={sq(usp)} where key='home_usp';",
    f"update public.settings set value={sq(counters)} where key='home_counters';",
    f"update public.settings set value={sq(parallax)} where key='home_parallax';",
    f"update public.settings set value={sq(offer)} where key='home_offer';",
]
seen = set()
for src, alt in alts:
    if src in seen:
        continue
    seen.add(src)
    sql.append(f"update public.usp_items set icon_alt='{alt}' where icon='{src}';")

sql.insert(0, "alter table public.usp_items add column if not exists icon_alt text;")

out = os.environ.get('OUT_SQL', 'supabase/migrations/0003_home_sections.sql')
open(out, 'w', encoding='utf8').write('\n'.join(sql) + '\n')
print('napisano', out)
print(json.dumps({'about': about, 'counters': counters, 'parallax': parallax, 'offer': offer, 'usp': usp}, ensure_ascii=False)[:900])
