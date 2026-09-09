/**
 * Wizualny edytor strony — dziala na prawdziwych podstronach, nie w osobnym podgladzie.
 * Wczytuje sie wylacznie wtedy, gdy w przegladarce jest sesja redakcji (ten sam klucz
 * co panel /admin), wiec zwykly odwiedzajacy nie pobiera ani bajta tego kodu.
 */
import { createClient } from '@supabase/supabase-js';
import { SUPABASE_URL, SUPABASE_ANON_KEY } from '../lib/config';
import './editor.css';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: { persistSession: true, autoRefreshToken: true, storageKey: 'softcar-admin' },
});

const FRAGMENT_SEPARATOR = '<!--GALERIA-->';

/* ---------------------------------------------------------------- pomocnicze */

const el = (tag, props = {}, kids = []) => {
  const n = document.createElement(tag);
  Object.entries(props).forEach(([k, v]) => {
    if (k === 'class') n.className = v;
    else if (k === 'html') n.innerHTML = v;
    else if (k.startsWith('on')) n.addEventListener(k.slice(2), v);
    else if (v != null) n.setAttribute(k, v);
  });
  (Array.isArray(kids) ? kids : [kids]).forEach((k) => k && n.append(k));
  return n;
};

function setPath(obj, path, value) {
  const parts = path.split('.');
  let cur = obj;
  for (let i = 0; i < parts.length - 1; i++) {
    const k = parts[i];
    const nextIsIndex = /^\d+$/.test(parts[i + 1]);
    if (cur[k] == null || typeof cur[k] !== 'object') cur[k] = nextIsIndex ? [] : {};
    cur = cur[k];
  }
  cur[parts.at(-1)] = value;
  return obj;
}

/**
 * Zdejmuje z tresci slady dzialania skryptow frontu i samego edytora,
 * zeby do bazy trafil czysty HTML — taki, jaki redakcja widzi w tresci.
 */
function captureHtml(node) {
  const copy = node.cloneNode(true);

  copy.querySelectorAll('[contenteditable], [data-sc], [spellcheck]').forEach((n) => {
    n.removeAttribute('contenteditable');
    n.removeAttribute('spellcheck');
    n.removeAttribute('data-sc');
    n.removeAttribute('data-sc-bound');
    n.removeAttribute('data-sc-type');
    n.removeAttribute('data-sc-label');
  });

  // galeria jest osobna lista w panelu — nigdy nie zapisujemy jej do tresci strony
  copy.querySelectorAll('[id^="droppicsgallery"]').forEach((n) => n.remove());

  // opakowanie tabel dokladane przez site.js na waskich ekranach
  copy.querySelectorAll('.table-responsive').forEach((w) => w.replaceWith(...w.childNodes));

  // klasy dokladane przyciskom przez site.js
  copy.querySelectorAll('a.btn, button.btn').forEach((b) => {
    b.classList.remove('border-radius-sm', 'btn-shadow');
    if (!b.getAttribute('class')) b.removeAttribute('class');
  });

  // wysokosci wyrownywane skryptem
  copy.querySelectorAll('.inner[style]').forEach((n) => {
    n.style.removeProperty('height');
    if (!n.getAttribute('style')) n.removeAttribute('style');
  });

  copy.querySelectorAll('.sce-fmt, .sce-tip').forEach((n) => n.remove());

  return copy.innerHTML.trim();
}

/* ---------------------------------------------------------------- stan */

const state = {
  /** klucz `tabela:id:pole` -> { table, id, field, value } */
  pending: new Map(),
  busy: false,
  page: null,
};

const key = (t, id, f) => `${t}:${id}:${f}`;

/* ---------------------------------------------------------------- pasek narzedzi */

let ui = {};

function buildBar() {
  const status = el('span', { class: 'sce-status clean' }, 'Wszystko zapisane');
  const save = el('button', { class: 'primary', onclick: saveAll }, 'Zapisz');
  const publish = el('button', { onclick: publishSite }, 'Opublikuj');
  const panel = el('a', { class: 'sce-btn', href: '/admin/' }, 'Panel');
  const exit = el('button', { onclick: leave }, 'Zakończ');
  const hint = el('span', { class: 'sce-hint' }, 'Kliknij dowolny tekst lub obraz, aby go zmienić.');

  const bar = el('div', { class: 'sce-bar' }, [
    el('span', { class: 'sce-logo' }, 'EDYCJA STRONY'),
    status, hint,
    el('span', { class: 'sce-spacer' }),
    save, publish, panel, exit,
  ]);
  document.body.append(bar);
  ui = { bar, status, save, publish, hint };
  refreshStatus();
}

function refreshStatus() {
  const n = state.pending.size;
  if (state.busy) return;
  ui.status.className = `sce-status ${n ? 'dirty' : 'clean'}`;
  ui.status.textContent = n
    ? `Niezapisane zmiany: ${n}`
    : 'Wszystko zapisane';
  ui.save.disabled = n === 0;
}

function setBusy(text) {
  state.busy = true;
  ui.status.className = 'sce-status busy';
  ui.status.textContent = text;
  ui.save.disabled = true;
  ui.publish.disabled = true;
}

function clearBusy() {
  state.busy = false;
  ui.publish.disabled = false;
  refreshStatus();
}

/* ---------------------------------------------------------------- edycja pol */

function mark(node, t, id, field, value) {
  state.pending.set(key(t, id, field), { table: t, id, field, value });
  node.classList.add('sce-changed');
  refreshStatus();
}

function bindText(node, t, id, field, type) {
  node.setAttribute('contenteditable', 'true');
  node.setAttribute('spellcheck', 'false');
  const original = type === 'html' ? captureHtml(node) : node.textContent;

  node.addEventListener('focus', () => {
    node.classList.add('sce-focus');
    if (type === 'html') showFormatBar(node);
  });
  node.addEventListener('blur', () => {
    node.classList.remove('sce-focus');
    hideFormatBar();
    const now = type === 'html' ? captureHtml(node) : node.textContent.trim();
    if (now === original) return;
    if (type === 'number') {
      const v = parseInt(String(now).replace(/\D+/g, ''), 10);
      if (Number.isNaN(v)) { node.textContent = original; return; }
      mark(node, t, id, field, v);
    } else {
      mark(node, t, id, field, now);
    }
  });
  node.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') node.blur();
    if (type !== 'html' && e.key === 'Enter') { e.preventDefault(); node.blur(); }
  });
  node.addEventListener('paste', (e) => {
    e.preventDefault();
    document.execCommand('insertText', false, e.clipboardData.getData('text/plain'));
  });
}

function bindImage(node, t, id, field) {
  node.addEventListener('click', (e) => {
    e.preventDefault();
    e.stopPropagation();
    openMediaPicker(node.getAttribute('src'), (url) => {
      node.setAttribute('src', url);
      node.removeAttribute('srcset');
      const picture = node.closest('picture');
      if (picture) picture.querySelectorAll('source').forEach((s) => s.remove());
      mark(node, t, id, field, url);
    });
  });
}

function scan() {
  document.querySelectorAll('[data-sc]').forEach((node) => {
    if (node.dataset.scBound) return;
    const [t, id, field, type = 'text'] = node.dataset.sc.split(':');
    if (!t || !id || !field) return;
    node.dataset.scBound = '1';
    node.dataset.scType = type;
    if (type === 'image') bindImage(node, t, id, field);
    else bindText(node, t, id, field, type);
  });
}

/* ---------------------------------------------------------------- pasek formatowania */

let fmtBar = null;

function showFormatBar(node) {
  hideFormatBar();
  const cmd = (c, a) => (e) => { e.preventDefault(); document.execCommand(c, false, a); };
  fmtBar = el('div', { class: 'sce-fmt' }, [
    el('button', { title: 'Pogrubienie', onmousedown: cmd('bold') }, 'B'),
    el('button', { title: 'Kursywa', onmousedown: cmd('italic') }, 'I'),
    el('button', { title: 'Nagłówek', onmousedown: cmd('formatBlock', 'h2') }, 'H2'),
    el('button', { title: 'Akapit', onmousedown: cmd('formatBlock', 'p') }, 'P'),
    el('button', { title: 'Lista', onmousedown: cmd('insertUnorderedList') }, '• Lista'),
    el('button', {
      title: 'Odnośnik',
      onmousedown: (e) => {
        e.preventDefault();
        const url = prompt('Adres odnośnika');
        if (url) document.execCommand('createLink', false, url);
      },
    }, 'Link'),
    el('button', { title: 'Usuń formatowanie', onmousedown: cmd('removeFormat') }, 'Czyść'),
  ]);
  document.body.append(fmtBar);
  const r = node.getBoundingClientRect();
  fmtBar.style.top = `${Math.max(8, r.top + window.scrollY - fmtBar.offsetHeight - 8)}px`;
  fmtBar.style.left = `${Math.max(8, r.left + window.scrollX)}px`;
}

function hideFormatBar() {
  fmtBar?.remove();
  fmtBar = null;
}

/* ---------------------------------------------------------------- biblioteka plikow */

function openMediaPicker(current, onPick) {
  const grid = el('div', { class: 'grid' });
  const url = el('input', { type: 'text', value: current ?? '', placeholder: 'lub wklej adres obrazu' });
  const file = el('input', { type: 'file', accept: 'image/*' });
  const info = el('span', { class: 'sce-hint' });

  const close = () => modal.remove();
  const use = (u) => { onPick(u); close(); };

  file.addEventListener('change', async () => {
    const f = file.files?.[0];
    if (!f) return;
    info.textContent = 'Wysyłanie…';
    try {
      const safe = f.name.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9.\-_]+/g, '-');
      const path = `${new Date().getFullYear()}/${Date.now()}-${safe}`;
      const { error } = await supabase.storage.from('media').upload(path, f, { cacheControl: '31536000', contentType: f.type });
      if (error) throw error;
      const pub = supabase.storage.from('media').getPublicUrl(path).data.publicUrl;
      await supabase.from('media').insert({ path, url: pub, alt: '', size_bytes: f.size });
      use(pub);
    } catch (e) {
      info.textContent = e.message ?? 'Nie udało się wysłać pliku';
    }
  });

  const box = el('div', { class: 'box' }, [
    el('h3', {}, 'Wybierz obraz'),
    el('div', { class: 'row' }, [file, info]),
    el('div', { class: 'row' }, [url, el('button', { class: 'primary', onclick: () => url.value && use(url.value.trim()) }, 'Użyj adresu'), el('button', { onclick: close }, 'Anuluj')]),
    grid,
  ]);
  const modal = el('div', { class: 'sce-modal', onmousedown: (e) => e.target === modal && close() }, box);
  document.body.append(modal);

  supabase.from('media').select('url,alt').order('created_at', { ascending: false }).limit(60)
    .then(({ data }) => {
      (data ?? []).forEach((m) => grid.append(el('img', { src: m.url, alt: m.alt ?? '', onclick: () => use(m.url) })));
      if (!data?.length) grid.append(el('p', { class: 'sce-hint' }, 'Biblioteka jest pusta — wgraj pierwszy plik powyżej.'));
    });
}

/* ---------------------------------------------------------------- zapis */

async function saveAll() {
  if (!state.pending.size) return;
  setBusy('Zapisywanie…');
  try {
    const items = [...state.pending.values()];

    // pola zwykłych tabel — grupujemy po wierszu, żeby zrobić jeden zapis
    const rows = new Map();
    // pola tekstowe rozbite na fragmenty (np. treść wokół galerii)
    const fragments = new Map();

    for (const it of items) {
      if (it.table === 'settings') continue;
      const m = it.field.match(/^(.+)#(\d+)$/);
      if (m) {
        const fk = `${it.table}:${it.id}:${m[1]}`;
        if (!fragments.has(fk)) fragments.set(fk, { table: it.table, id: it.id, field: m[1], parts: new Map() });
        fragments.get(fk).parts.set(Number(m[2]), it.value);
      } else {
        const rk = `${it.table}:${it.id}`;
        if (!rows.has(rk)) rows.set(rk, { table: it.table, id: it.id, patch: {} });
        rows.get(rk).patch[it.field] = it.value;
      }
    }

    // brakujące fragmenty dobieramy z aktualnej strony, żeby nie zgubić tekstu
    for (const f of fragments.values()) {
      const nodes = [...document.querySelectorAll(`[data-sc^="${f.table}:${f.id}:${f.field}#"]`)];
      nodes.forEach((n) => {
        const idx = Number(n.dataset.sc.match(/#(\d+)/)[1]);
        if (!f.parts.has(idx)) f.parts.set(idx, captureHtml(n));
      });
      const joined = [...f.parts.entries()].sort((a, b) => a[0] - b[0]).map((e) => e[1]).join(FRAGMENT_SEPARATOR);
      const rk = `${f.table}:${f.id}`;
      if (!rows.has(rk)) rows.set(rk, { table: f.table, id: f.id, patch: {} });
      rows.get(rk).patch[f.field] = joined;
    }

    for (const r of rows.values()) {
      const { error } = await supabase.from(r.table).update(r.patch).eq('id', r.id);
      if (error) throw new Error(`${r.table}: ${error.message}`);
    }

    // ustawienia trzymane jako JSON — czytamy aktualną wartość i podmieniamy ścieżkę
    const settings = new Map();
    items.filter((i) => i.table === 'settings').forEach((i) => {
      if (!settings.has(i.id)) settings.set(i.id, []);
      settings.get(i.id).push(i);
    });
    for (const [k, list] of settings) {
      const { data, error } = await supabase.from('settings').select('value').eq('key', k).single();
      if (error) throw new Error(`settings ${k}: ${error.message}`);
      const value = data.value ?? {};
      list.forEach((i) => setPath(value, i.field, i.value));
      const up = await supabase.from('settings').update({ value, updated_at: new Date().toISOString() }).eq('key', k);
      if (up.error) throw new Error(`settings ${k}: ${up.error.message}`);
    }

    await logChanges(items);

    state.pending.clear();
    document.querySelectorAll('.sce-changed').forEach((n) => n.classList.remove('sce-changed'));
    clearBusy();
    ui.hint.textContent = 'Zapisano w bazie. Kliknij „Opublikuj”, aby zmiany trafiły na stronę publiczną.';
  } catch (e) {
    clearBusy();
    ui.status.className = 'sce-status dirty';
    ui.status.textContent = 'Błąd zapisu';
    alert(`Nie udało się zapisać:\n${e.message}`);
  }
}

async function logChanges(items) {
  try {
    const { data } = await supabase.auth.getUser();
    await supabase.from('audit_log').insert(
      items.map((i) => ({
        actor: data?.user?.email ?? null,
        action: 'update',
        entity: i.table,
        entity_id: String(i.id),
        payload: { field: i.field, source: 'edytor wizualny' },
      })),
    );
  } catch {
    /* dziennik nie moze blokowac zapisu tresci */
  }
}

/* ---------------------------------------------------------------- publikacja */

async function currentBuild() {
  try {
    const r = await fetch(`/build.json?t=${Date.now()}`, { cache: 'no-store' });
    return r.ok ? (await r.json()).built : null;
  } catch { return null; }
}

async function publishSite() {
  if (state.pending.size && !confirm('Masz niezapisane zmiany — zostaną pominięte. Publikować mimo to?')) return;
  const before = await currentBuild();
  setBusy('Publikowanie…');
  try {
    const { data: s } = await supabase.from('settings').select('value').eq('key', 'deploy').single();
    const session = (await supabase.auth.getSession()).data.session;
    const r = await fetch(s.value.function_url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session?.access_token ?? ''}` },
      body: JSON.stringify({ reason: 'edytor' }),
    });
    if (!r.ok) throw new Error(`Serwer odpowiedział ${r.status}`);

    ui.status.textContent = 'Publikowanie… (ok. minuty)';
    const started = Date.now();
    const tick = setInterval(async () => {
      const now = await currentBuild();
      if (now && now !== before) {
        clearInterval(tick);
        ui.status.className = 'sce-status clean';
        ui.status.textContent = 'Opublikowano — odświeżam…';
        setTimeout(() => location.reload(), 900);
      } else if (Date.now() - started > 5 * 60 * 1000) {
        clearInterval(tick);
        clearBusy();
        ui.hint.textContent = 'Publikacja trwa dłużej niż zwykle — sprawdź zakładkę Actions na GitHubie.';
      }
    }, 8000);
  } catch (e) {
    clearBusy();
    alert(`Nie udało się opublikować:\n${e.message}`);
  }
}

/* ---------------------------------------------------------------- wejscie / wyjscie */

function showLauncher() {
  const btn = el('button', {
    class: 'sce-launch',
    title: 'Edytuj treść tej strony',
    onclick: () => {
      sessionStorage.setItem('sce-active', '1');
      location.reload();
    },
  }, 'Edytuj stronę');
  document.body.append(btn);
}

function leave() {
  if (state.pending.size && !confirm('Masz niezapisane zmiany. Wyjść bez zapisania?')) return;
  sessionStorage.removeItem('sce-active');
  const u = new URL(location.href);
  u.searchParams.delete('edit');
  location.href = u.toString();
}

export async function init() {
  const { data } = await supabase.auth.getSession();
  if (!data.session) return;
  const { data: admin } = await supabase.from('admin_users').select('id').eq('id', data.session.user.id).maybeSingle();
  if (!admin) return;

  // Sam fakt zalogowania nie wlacza jeszcze trybu edycji — redakcja widzi dyskretny
  // przycisk i sama decyduje, kiedy zaczac edytowac. Tryb trzyma sie karty przegladarki.
  const wanted = new URLSearchParams(location.search).has('edit') || sessionStorage.getItem('sce-active') === '1';
  if (!wanted) {
    showLauncher();
    return;
  }

  document.body.classList.add('sce-on');
  buildBar();
  scan();

  // podpowiedz z nazwa pola przy najechaniu
  const tip = el('div', { class: 'sce-tip' });
  tip.style.display = 'none';
  document.body.append(tip);
  document.addEventListener('mouseover', (e) => {
    const t = e.target.closest?.('[data-sc]');
    if (!t) { tip.style.display = 'none'; return; }
    tip.textContent = t.dataset.scLabel ?? 'Element';
    const r = t.getBoundingClientRect();
    tip.style.display = 'block';
    tip.style.top = `${r.top - 4}px`;
    tip.style.left = `${r.left}px`;
  });

  // odnosniki nie maja nawigowac w trybie edycji
  document.addEventListener('click', (e) => {
    const a = e.target.closest('a');
    if (!a || a.closest('.sce-bar') || a.closest('.sce-modal')) return;
    if (a.hasAttribute('data-sc') || a.closest('[data-sc]')) e.preventDefault();
  }, true);

  window.addEventListener('beforeunload', (e) => {
    if (!state.pending.size) return;
    e.preventDefault();
    e.returnValue = '';
  });

  sessionStorage.setItem('sce-active', '1');
}
