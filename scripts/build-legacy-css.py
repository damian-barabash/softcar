#!/usr/bin/env python3
"""Skleja arkusze stylow starego serwisu (kazda podstrona miala wlasny pakiet JCH)
w jeden plik, usuwa nieuzywane @font-face i przepisuje sciezki do zasobow."""
import re, os, sys

S = os.environ.get('SCR', '/private/tmp/claude-501/-Users-dmytrii-Desktop-PROJEKTY-SOFTCAR/c97d551d-dc54-47ae-a014-ce15fe4b03e2/scratchpad')
OUT = '/Users/dmytrii/Desktop/PROJEKTY/SOFTCAR/softcar/src/styles'
# kolejnosc ma znaczenie: pakiet strony glownej jest najpelniejszy
BUNDLES = ['e2d47c55afc576c9b37fd0679ab9a338.css', '81d67ef996b43494adcb3c8457a2aabd.css',
           'abcd26da0b96307353debc3f51ddcfc8.css', '05e50a20b3400c9e535423e26faf9c5d.css']

def chunks(css):
    """Dzieli arkusz na bloki najwyzszego poziomu (regula lub @media/@keyframes)."""
    out, i, n = [], 0, len(css)
    while i < n:
        j = css.find('{', i)
        if j < 0:
            break
        depth, k = 1, j + 1
        while k < n and depth:
            if css[k] == '{':
                depth += 1
            elif css[k] == '}':
                depth -= 1
            k += 1
        out.append(css[i:k].strip())
        i = k
    return [c for c in out if c]

seen, merged = set(), []
for f in BUNDLES:
    p = f'{S}/css/{f}'
    if not os.path.exists(p):
        print('pomijam (brak):', f); continue
    for c in chunks(open(p, encoding='utf8', errors='replace').read()):
        if c not in seen:
            seen.add(c); merged.append(c)
    print(f'{f}: lacznie blokow {len(merged)}')

# style osadzone w <style> na podstronach (banner, okruszki, galeria)
inline = open(f'{S}/inline.css', encoding='utf8').read()
for c in chunks(inline):
    if c not in seen:
        seen.add(c); merged.append(c)

css = '\n'.join(merged)

KEEP = re.compile(r'poppins|fahkwang|glyphicons|archivo-regular', re.I)
css = re.sub(r'@font-face\s*\{[^}]*\}', lambda m: m.group(0) if KEEP.search(m.group(0)) else '', css)
css = (css.replace('../templates/site/fonts/', '/fonts/')
          .replace('../images/', '/images/').replace('../media/', '/media/')
          .replace('../templates/', '/templates/')
          .replace('https://softcarservice.pl/', '/')
          .replace('../components/', '/components/'))
# hostujemy wylacznie woff2 — reszta formatow to martwe odwolania ze starego szablonu
# (adresy bywaja w cudzyslowach, stad opcjonalny znak cytatu we wzorcu)
css = re.sub(r'url\(["\']?/fonts/[^)]+?\.(?:eot|svg|ttf)[^)]*\)\s*format\((["\'])[^)]*?\1\)\s*,?', '', css)
css = re.sub(r'url\(["\']?/fonts/[^)]+?\.(?:eot|svg|ttf)[^)]*\)\s*,?', '', css)
css = re.sub(r'src:\s*,', 'src:', css)
css = re.sub(r',\s*(?=[;}])', '', css)
css = re.sub(r'src:\s*(?=[;}])', '', css)
css = re.sub(r'src:\s*url\(/fonts/[^)]+\.eot[^)]*\);', '', css)
css = re.sub(r'url\(/fonts/glyphicons-halflings-regular\.eot\?#iefix\)\s*format\((["\'])embedded-opentype\1\),?', '', css)
# hostujemy wylacznie woff2 — usuwamy odwolania do eot/svg/ttf, ktore i tak konczylyby sie 404
css = re.sub(r'url\(/fonts/[^)]+\.(?:eot|svg|ttf)[^)]*\)\s*(?:format\((["\'])[^)]*\1\))?,?', '', css)
css = re.sub(r'src:\s*;', '', css)
css = re.sub(r'src:\s*,', 'src:', css)

# klasy .tlo1-.tlo6 wskazuja na tla, ktorych nie ma juz na starym serwerze (404) i nigdzie nie sa uzywane
css = re.sub(r'\.tlo[1-6]\{[^}]*\}', '', css)

# uszkodzone deklaracje z generatora starego szablonu (PostCSS na nich pada)
css = re.sub(r'([;{])opacity:(?=-webkit-|-moz-|-o-|transition:)', r'\1', css)
css = re.sub(r'([;{])[a-zA-Z-]+:\s*(?=[;}])', r'\1', css)
css = re.sub(r'([\w%)])\s*:\s*(?=[;}])', r'\1', css)
css = re.sub(r';{2,}', ';', css)

open(f'{OUT}/legacy.css', 'w', encoding='utf8').write(css)

d = open(f'{S}/css/desktop.css', encoding='utf8', errors='replace').read()
d = (d.replace('../templates/site/fonts/', '/fonts/').replace('../images/', '/images/')
      .replace('../media/', '/media/').replace('https://softcarservice.pl/', '/'))
d = re.sub(r'([;{])opacity:(?=-webkit-|-moz-|-o-|transition:)', r'\1', d)
d = re.sub(r'([\w%)])\s*:\s*(?=[;}])', r'\1', d)
# oryginal ladowal ten arkusz z media="screen and (min-width: 768px)"
d = '@media screen and (min-width: 768px){\n' + d + '\n}'
open(f'{OUT}/legacy-desktop.css', 'w', encoding='utf8').write(d)
print('legacy.css', len(css), '| legacy-desktop.css', len(d))
