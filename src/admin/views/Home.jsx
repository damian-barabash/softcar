import React, { useState } from 'react';
import { list, update, insert, remove, getSettings, saveSetting } from '../lib';
import { useAsync, Loading, ErrorBox, Field, Text, Area, Toggle, Modal, orderTools } from '../ui.jsx';
import MediaPicker from '../MediaPicker.jsx';
import Editor from '../Editor.jsx';

export default function Home({ toast }) {
  const { data, loading, error, reload } = useAsync(async () => ({
    slides: await list('slides'),
    info: await list('info_boxes'),
    usp: await list('usp_items'),
    counters: await list('counters'),
    offer: await list('offer_tiles'),
    settings: await getSettings(),
  }));
  if (loading) return <Loading />;
  if (error) return <ErrorBox error={error} />;
  const S = Object.fromEntries((data.settings ?? []).map((s) => [s.key, s.value]));

  return (
    <>
      <div className="topbar"><h1>Strona główna</h1></div>
      <Slides rows={data.slides} reload={reload} toast={toast} />
      <SectionText title="Sekcja „O nas”" k="home_about" v={S.home_about} reload={reload} toast={toast} />
      <UspBlock rows={data.usp} kicker={S.home_usp} reload={reload} toast={toast} />
      <Marquee v={S.home_marquee} reload={reload} toast={toast} />
      <CountersBlock rows={data.counters} head={S.home_counters} reload={reload} toast={toast} />
      <Parallax v={S.home_parallax} reload={reload} toast={toast} />
      <OfferTiles rows={data.offer} head={S.home_offer} reload={reload} toast={toast} />
      <InfoBoxes rows={data.info} reload={reload} toast={toast} />
    </>
  );
}

function useSwap(table, rows, reload) {
  return async (a, b) => {
    await update(table, rows[a].id, { sort: rows[b].sort });
    await update(table, rows[b].id, { sort: rows[a].sort });
    reload();
  };
}

function ImageField({ label, value, onChange }) {
  const [pick, setPick] = useState(false);
  return (
    <>
      <Field label={label}>
        <div style={{ display: 'flex', gap: 8 }}>
          <Text value={value} onChange={onChange} />
          <button className="btn ghost sm" onClick={() => setPick(true)}>Wybierz</button>
        </div>
        {value && <img src={value} alt="" style={{ marginTop: 8, maxHeight: 90, borderRadius: 4 }} />}
      </Field>
      {pick && <MediaPicker onClose={() => setPick(false)} onPick={(m) => { onChange(m.url); setPick(false); }} />}
    </>
  );
}

/* ---------------- slider ---------------- */
function Slides({ rows, reload, toast }) {
  const [edit, setEdit] = useState(null);
  const swap = useSwap('slides', rows, reload);
  return (
    <div className="card">
      <h2>Slider (banery na górze)</h2>
      <table className="list">
        <thead><tr><th>Podgląd</th><th>Nagłówek</th><th>Przycisk</th><th>Status</th><th className="right">Akcje</th></tr></thead>
        <tbody>
          {rows.map((s, i) => (
            <tr key={s.id}>
              <td>{s.image && <img src={s.image} alt="" style={{ height: 40, borderRadius: 3 }} />}</td>
              <td><strong dangerouslySetInnerHTML={{ __html: s.title ?? '' }} /><br /><small className="muted">{s.kicker}</small></td>
              <td className="muted">{s.button_label}</td>
              <td><span className={`pill ${s.is_published ? 'on' : 'off'}`}>{s.is_published ? 'widoczny' : 'ukryty'}</span></td>
              <td className="right"><div className="row-actions">
                {orderTools(rows, i, swap)}
                <button className="btn ghost sm" onClick={() => setEdit(s)}>Edytuj</button>
                <button className="btn danger sm" onClick={async () => { if (confirm('Usunąć slajd?')) { await remove('slides', s.id); reload(); } }}>Usuń</button>
              </div></td>
            </tr>
          ))}
        </tbody>
      </table>
      <button className="btn ghost sm" style={{ marginTop: 12 }} onClick={() => setEdit({ sort: (rows.at(-1)?.sort ?? 0) + 10, is_published: true, css_slide: 32 })}>+ Dodaj slajd</button>
      {edit && <SlideForm s={edit} onClose={() => setEdit(null)} onSave={async (v) => {
        const { id, ...rest } = v;
        id ? await update('slides', id, rest) : await insert('slides', rest);
        toast('Zapisano slajd'); setEdit(null); reload();
      }} />}
    </div>
  );
}

function SlideForm({ s, onSave, onClose }) {
  const [v, setV] = useState(s);
  const set = (k) => (x) => setV((o) => ({ ...o, [k]: x }));
  return (
    <Modal title="Slajd" onClose={onClose} wide>
      <ImageField label="Obraz tła (zalecane 1920×900)" value={v.image} onChange={set('image')} />
      <div className="grid2">
        <Field label="Nadtytuł" hint="mały napis nad nagłówkiem"><Text value={v.kicker} onChange={set('kicker')} /></Field>
        <Field label="Nagłówek"><Text value={v.title} onChange={set('title')} /></Field>
        <Field label="Tekst przycisku"><Text value={v.button_label} onChange={set('button_label')} /></Field>
        <Field label="Adres przycisku"><Text value={v.button_href} onChange={set('button_href')} /></Field>
      </div>
      <Field label="Treść slajdu"><Editor value={v.body_html} onChange={set('body_html')} /></Field>
      <Toggle value={v.is_published} onChange={set('is_published')} label="Slajd widoczny" />
      <button className="btn" onClick={() => onSave(v)}>Zapisz</button>
    </Modal>
  );
}

/* ---------------- sekcja tekstowa (O nas) ---------------- */
function SectionText({ title, k, v, reload, toast }) {
  const [d, setD] = useState(v ?? {});
  const set = (path) => (x) => setD((o) => ({ ...o, [path]: x }));
  const setCta = (path) => (x) => setD((o) => ({ ...o, cta: { ...(o.cta ?? {}), [path]: x } }));
  return (
    <div className="card">
      <h2>{title}</h2>
      <div className="grid2">
        <Field label="Nadtytuł"><Text value={d.kicker} onChange={set('kicker')} /></Field>
        <Field label="Nagłówek"><Text value={d.heading} onChange={set('heading')} /></Field>
      </div>
      <Field label="Treść"><Editor value={d.body_html} onChange={set('body_html')} /></Field>
      <h2 style={{ marginTop: 20 }}>Pomarańczowy box obok</h2>
      <div className="grid2">
        <Field label="Tytuł boxu"><Text value={d.cta?.title} onChange={setCta('title')} /></Field>
        <Field label="Tekst przycisku"><Text value={d.cta?.button_label} onChange={setCta('button_label')} /></Field>
        <Field label="Adres przycisku"><Text value={d.cta?.button_href} onChange={setCta('button_href')} /></Field>
      </div>
      <Field label="Treść boxu"><Area value={d.cta?.body_html} onChange={setCta('body_html')} rows={3} /></Field>
      <button className="btn" onClick={async () => { await saveSetting(k, d); toast('Zapisano'); reload(); }}>Zapisz sekcję</button>
    </div>
  );
}

/* ---------------- USP ---------------- */
function UspBlock({ rows, kicker, reload, toast }) {
  const [k, setK] = useState(kicker ?? {});
  const swap = useSwap('usp_items', rows, reload);
  return (
    <div className="card">
      <h2>Sekcja „To co nas wyróżnia”</h2>
      <div className="grid2">
        <Field label="Nadtytuł sekcji"><Text value={k.kicker} onChange={(v) => setK({ ...k, kicker: v })} /></Field>
        <div style={{ alignSelf: 'end', marginBottom: 14 }}>
          <button className="btn ghost" onClick={async () => { await saveSetting('home_usp', k); toast('Zapisano'); }}>Zapisz nagłówek</button>
        </div>
      </div>
      <table className="list">
        <thead><tr><th>Ikona</th><th>Podpis</th><th className="right">Akcje</th></tr></thead>
        <tbody>
          {rows.map((u, i) => (
            <tr key={u.id}>
              <td>{u.icon && <img src={u.icon} alt="" style={{ height: 28 }} />}</td>
              <td>
                <input type="text" defaultValue={u.label} onBlur={(e) => update('usp_items', u.id, { label: e.target.value })} />
              </td>
              <td className="right"><div className="row-actions">
                {orderTools(rows, i, swap)}
                <button className="btn danger sm" onClick={async () => { if (confirm('Usunąć?')) { await remove('usp_items', u.id); reload(); } }}>Usuń</button>
              </div></td>
            </tr>
          ))}
        </tbody>
      </table>
      <button className="btn ghost sm" style={{ marginTop: 12 }} onClick={async () => {
        await insert('usp_items', { label: 'Nowa cecha', sort: (rows.at(-1)?.sort ?? 0) + 10 }); reload();
      }}>+ Dodaj cechę</button>
    </div>
  );
}

/* ---------------- pasek przewijany ---------------- */
function Marquee({ v, reload, toast }) {
  const [d, setD] = useState(v ?? {});
  return (
    <div className="card">
      <h2>Pasek przewijany</h2>
      <Field label="Tekst"><Text value={d.text} onChange={(x) => setD({ ...d, text: x })} /></Field>
      <button className="btn" onClick={async () => { await saveSetting('home_marquee', d); toast('Zapisano'); reload(); }}>Zapisz</button>
    </div>
  );
}

/* ---------------- liczniki ---------------- */
function CountersBlock({ rows, head, reload, toast }) {
  const [h, setH] = useState(head ?? {});
  return (
    <div className="card">
      <h2>Liczniki („Nasze osiągnięcia”)</h2>
      <div className="grid2">
        <Field label="Nadtytuł"><Text value={h.kicker} onChange={(v) => setH({ ...h, kicker: v })} /></Field>
        <Field label="Nagłówek"><Text value={h.heading} onChange={(v) => setH({ ...h, heading: v })} /></Field>
      </div>
      <Field label="Opis"><Area value={h.body_html} onChange={(v) => setH({ ...h, body_html: v })} rows={2} /></Field>
      <button className="btn ghost" onClick={async () => { await saveSetting('home_counters', h); toast('Zapisano'); }}>Zapisz nagłówek</button>
      <table className="list" style={{ marginTop: 16 }}>
        <thead><tr><th>Wartość</th><th>Podpis</th><th className="right">Akcje</th></tr></thead>
        <tbody>
          {rows.map((c) => (
            <tr key={c.id}>
              <td style={{ width: 120 }}>
                <input type="number" defaultValue={c.value} onBlur={(e) => update('counters', c.id, { value: parseInt(e.target.value || '0', 10) })} />
              </td>
              <td><input type="text" defaultValue={c.label} onBlur={(e) => update('counters', c.id, { label: e.target.value })} /></td>
              <td className="right">
                <button className="btn danger sm" onClick={async () => { if (confirm('Usunąć?')) { await remove('counters', c.id); reload(); } }}>Usuń</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <button className="btn ghost sm" style={{ marginTop: 12 }} onClick={async () => {
        await insert('counters', { value: 0, label: 'Nowy licznik', sort: (rows.at(-1)?.sort ?? 0) + 10, css_block: 954 }); reload();
      }}>+ Dodaj licznik</button>
    </div>
  );
}

/* ---------------- paralaksa ---------------- */
function Parallax({ v, reload, toast }) {
  const [d, setD] = useState(v ?? {});
  const setBtn = (k) => (x) => setD((o) => ({ ...o, button: { ...(o.button ?? {}), [k]: x } }));
  return (
    <div className="card">
      <h2>Sekcja „Zapraszamy do kontaktu”</h2>
      <Field label="Nagłówek"><Text value={d.heading} onChange={(x) => setD({ ...d, heading: x })} /></Field>
      <Field label="Treść"><Editor value={d.body_html} onChange={(x) => setD({ ...d, body_html: x })} /></Field>
      <div className="grid2">
        <Field label="Tekst przycisku"><Text value={d.button?.label} onChange={setBtn('label')} /></Field>
        <Field label="Adres przycisku"><Text value={d.button?.href} onChange={setBtn('href')} /></Field>
      </div>
      <button className="btn" onClick={async () => { await saveSetting('home_parallax', d); toast('Zapisano'); reload(); }}>Zapisz</button>
    </div>
  );
}

/* ---------------- kafelki oferty ---------------- */
function OfferTiles({ rows, head, reload, toast }) {
  const [h, setH] = useState(head ?? {});
  const [edit, setEdit] = useState(null);
  const [place, setPlace] = useState('home');
  const filtered = rows.filter((r) => r.placement === place);
  const swap = useSwap('offer_tiles', filtered, reload);
  return (
    <div className="card">
      <h2>Kafelki oferty</h2>
      <div className="grid2">
        <Field label="Nadtytuł (strona główna)"><Text value={h.kicker} onChange={(v) => setH({ ...h, kicker: v })} /></Field>
        <Field label="Nagłówek (strona główna)"><Text value={h.heading} onChange={(v) => setH({ ...h, heading: v })} /></Field>
      </div>
      <button className="btn ghost" onClick={async () => { await saveSetting('home_offer', h); toast('Zapisano'); }}>Zapisz nagłówek</button>

      <div style={{ margin: '18px 0 10px', display: 'flex', gap: 8 }}>
        <button className={`btn ${place === 'home' ? '' : 'ghost'} sm`} onClick={() => setPlace('home')}>Strona główna ({rows.filter((r) => r.placement === 'home').length})</button>
        <button className={`btn ${place === 'oferta' ? '' : 'ghost'} sm`} onClick={() => setPlace('oferta')}>Strona /oferta ({rows.filter((r) => r.placement === 'oferta').length})</button>
      </div>

      <table className="list">
        <thead><tr><th>Obraz</th><th>Tytuł</th><th>Odnośnik</th><th className="right">Akcje</th></tr></thead>
        <tbody>
          {filtered.map((o, i) => (
            <tr key={o.id}>
              <td>{o.image && <img src={o.image} alt="" style={{ height: 40, borderRadius: '50%' }} />}</td>
              <td dangerouslySetInnerHTML={{ __html: o.title }} />
              <td className="muted">{o.href}</td>
              <td className="right"><div className="row-actions">
                {orderTools(filtered, i, swap)}
                <button className="btn ghost sm" onClick={() => setEdit(o)}>Edytuj</button>
                <button className="btn danger sm" onClick={async () => { if (confirm('Usunąć kafelek?')) { await remove('offer_tiles', o.id); reload(); } }}>Usuń</button>
              </div></td>
            </tr>
          ))}
        </tbody>
      </table>
      <button className="btn ghost sm" style={{ marginTop: 12 }} onClick={() => setEdit({
        placement: place, is_published: true, css_block: place === 'home' ? 1554 : 1691,
        sort: (filtered.at(-1)?.sort ?? 0) + 10, title: '', href: '/oferta',
      })}>+ Dodaj kafelek</button>

      {edit && <TileForm t={edit} onClose={() => setEdit(null)} onSave={async (v) => {
        const { id, ...rest } = v;
        id ? await update('offer_tiles', id, rest) : await insert('offer_tiles', rest);
        toast('Zapisano kafelek'); setEdit(null); reload();
      }} />}
    </div>
  );
}

function TileForm({ t, onSave, onClose }) {
  const [v, setV] = useState(t);
  const set = (k) => (x) => setV((o) => ({ ...o, [k]: x }));
  return (
    <Modal title="Kafelek oferty" onClose={onClose}>
      <ImageField label="Obraz (kwadrat, np. 768×768)" value={v.image} onChange={set('image')} />
      <Field label="Tytuł"><Text value={v.title} onChange={set('title')} /></Field>
      <Field label="Opis obrazu (alt)"><Text value={v.image_alt} onChange={set('image_alt')} /></Field>
      <Field label="Odnośnik"><Text value={v.href} onChange={set('href')} /></Field>
      <Toggle value={v.is_published} onChange={set('is_published')} label="Widoczny" />
      <button className="btn" onClick={() => onSave(v)}>Zapisz</button>
    </Modal>
  );
}

/* ---------------- bloki informacyjne ---------------- */
function InfoBoxes({ rows, reload, toast }) {
  const [edit, setEdit] = useState(null);
  const swap = useSwap('info_boxes', rows, reload);
  const PLACE = { home: 'Strona główna', pages: 'Podstrony', both: 'Wszędzie' };
  return (
    <div className="card">
      <h2>Bloki informacyjne (ogłoszenia)</h2>
      <table className="list">
        <thead><tr><th>Tytuł</th><th>Gdzie</th><th>Widoczność</th><th className="right">Akcje</th></tr></thead>
        <tbody>
          {rows.map((b, i) => (
            <tr key={b.id}>
              <td>{b.title || <span className="muted">(bez tytułu)</span>}</td>
              <td>{PLACE[b.placement]}</td>
              <td><span className={`pill ${b.is_published ? 'on' : 'off'}`}>{b.is_published ? 'widoczny' : 'ukryty'}</span></td>
              <td className="right"><div className="row-actions">
                {orderTools(rows, i, swap)}
                <button className="btn ghost sm" onClick={() => setEdit(b)}>Edytuj</button>
                <button className="btn danger sm" onClick={async () => { if (confirm('Usunąć blok?')) { await remove('info_boxes', b.id); reload(); } }}>Usuń</button>
              </div></td>
            </tr>
          ))}
        </tbody>
      </table>
      <button className="btn ghost sm" style={{ marginTop: 12 }} onClick={() => setEdit({
        placement: 'home', visibility: 'all', image_side: 'none', is_published: true, css_block: 1784,
        sort: (rows.at(-1)?.sort ?? 0) + 10, body_html: '',
      })}>+ Dodaj blok</button>
      {edit && <InfoForm b={edit} onClose={() => setEdit(null)} onSave={async (v) => {
        const { id, ...rest } = v;
        id ? await update('info_boxes', id, rest) : await insert('info_boxes', rest);
        toast('Zapisano blok'); setEdit(null); reload();
      }} />}
    </div>
  );
}

function InfoForm({ b, onSave, onClose }) {
  const [v, setV] = useState(b);
  const set = (k) => (x) => setV((o) => ({ ...o, [k]: x }));
  return (
    <Modal title="Blok informacyjny" onClose={onClose} wide>
      <div className="grid2">
        <Field label="Tytuł"><Text value={v.title} onChange={set('title')} /></Field>
        <Field label="Gdzie pokazywać">
          <select value={v.placement} onChange={(e) => set('placement')(e.target.value)}>
            <option value="home">Tylko strona główna</option>
            <option value="pages">Tylko podstrony</option>
            <option value="both">Wszędzie</option>
          </select>
        </Field>
        <Field label="Na jakich ekranach">
          <select value={v.visibility} onChange={(e) => set('visibility')(e.target.value)}>
            <option value="all">Wszystkie</option>
            <option value="mobile">Tylko telefony</option>
            <option value="desktop">Tylko komputery</option>
          </select>
        </Field>
        <Field label="Obraz obok">
          <select value={v.image_side} onChange={(e) => set('image_side')(e.target.value)}>
            <option value="none">Brak (obraz w treści)</option>
            <option value="left">Po lewej</option>
            <option value="right">Po prawej</option>
          </select>
        </Field>
      </div>
      {v.image_side !== 'none' && <ImageField label="Obraz" value={v.image} onChange={set('image')} />}
      <Field label="Treść"><Editor value={v.body_html} onChange={set('body_html')} /></Field>
      <Toggle value={v.is_published} onChange={set('is_published')} label="Widoczny" />
      <button className="btn" onClick={() => onSave(v)}>Zapisz</button>
    </Modal>
  );
}
