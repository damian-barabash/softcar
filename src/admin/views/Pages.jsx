import React, { useState } from 'react';
import { list, update, insert, remove } from '../lib';
import { useAsync, Loading, ErrorBox, Field, Text, Area, Toggle, Modal } from '../ui.jsx';
import Editor from '../Editor.jsx';

const KIND = { page: 'Strona', service: 'Usługa (Oferta)', legal: 'Dokument prawny' };

export default function Pages({ toast }) {
  const { data, loading, error, reload } = useAsync(() => list('pages', { order: 'kind' }));
  const [edit, setEdit] = useState(null);

  if (loading) return <Loading />;
  const pages = data ?? [];
  const groups = ['page', 'service', 'legal'];

  const save = async (p) => {
    try {
      const { id, created_at, updated_at, ...rest } = p;
      if (id) await update('pages', id, rest);
      else await insert('pages', rest);
      toast('Zapisano stronę');
      setEdit(null);
      reload();
    } catch (e) { toast(e.message, 'err'); }
  };

  return (
    <>
      <ErrorBox error={error} />
      <div className="topbar">
        <h1>Strony</h1>
        <div className="actions">
          <button className="btn" onClick={() => setEdit({ slug: '', kind: 'service', title: '', body_html: '', is_published: true, sort: 100, banner_image: '/images/design/banner.webp' })}>
            + Nowa strona
          </button>
        </div>
      </div>

      {groups.map((g) => (
        <div className="card" key={g}>
          <h2>{KIND[g]}</h2>
          <table className="list">
            <thead><tr><th>Tytuł</th><th>Adres</th><th>Status</th><th className="right">Akcje</th></tr></thead>
            <tbody>
              {pages.filter((p) => p.kind === g).map((p) => (
                <tr key={p.id}>
                  <td><strong>{p.title}</strong></td>
                  <td className="muted">/{p.kind === 'service' ? 'oferta/' : ''}{p.slug}</td>
                  <td><span className={`pill ${p.is_published ? 'on' : 'off'}`}>{p.is_published ? 'opublikowana' : 'ukryta'}</span></td>
                  <td className="right">
                    <div className="row-actions">
                      <a className="btn ghost sm" href={`/${p.kind === 'service' ? 'oferta/' : ''}${p.slug}`} target="_blank" rel="noreferrer">Podgląd</a>
                      <button className="btn ghost sm" onClick={() => setEdit(p)}>Edytuj</button>
                      <button className="btn danger sm" onClick={async () => {
                        if (!confirm(`Usunąć stronę „${p.title}”?`)) return;
                        await remove('pages', p.id); toast('Usunięto'); reload();
                      }}>Usuń</button>
                    </div>
                  </td>
                </tr>
              ))}
              {!pages.filter((p) => p.kind === g).length && <tr><td colSpan={4} className="muted">Brak stron.</td></tr>}
            </tbody>
          </table>
        </div>
      ))}

      {edit && <PageForm page={edit} onSave={save} onClose={() => setEdit(null)} />}
    </>
  );
}

function PageForm({ page, onSave, onClose }) {
  const [p, setP] = useState(page);
  const set = (k) => (v) => setP((x) => ({ ...x, [k]: v }));
  return (
    <Modal title={p.id ? `Edycja: ${p.title}` : 'Nowa strona'} onClose={onClose} wide>
      <div className="grid2">
        <Field label="Tytuł"><Text value={p.title} onChange={set('title')} /></Field>
        <Field label="Adres (slug)" hint="bez ukośników, np. auto-zastepcze"><Text value={p.slug} onChange={set('slug')} /></Field>
        <Field label="Rodzaj">
          <select value={p.kind} onChange={(e) => set('kind')(e.target.value)}>
            {Object.entries(KIND).map(([k, v]) => <option key={k} value={k}>{v}</option>)}
          </select>
        </Field>
        <Field label="Kolejność" hint="mniejsza liczba = wyżej"><Text value={String(p.sort ?? 0)} onChange={(v) => set('sort')(parseInt(v || '0', 10))} /></Field>
        <Field label="Tytuł SEO"><Text value={p.meta_title} onChange={set('meta_title')} /></Field>
        <Field label="Baner (adres obrazu)"><Text value={p.banner_image} onChange={set('banner_image')} /></Field>
      </div>
      <Field label="Opis SEO" hint="do 160 znaków"><Area value={p.meta_desc} onChange={set('meta_desc')} rows={2} /></Field>
      <Toggle value={p.is_published} onChange={set('is_published')} label="Strona opublikowana" />
      <Field label="Treść">
        <Editor value={p.body_html} onChange={set('body_html')} />
      </Field>
      <div style={{ display: 'flex', gap: 8, marginTop: 16 }}>
        <button className="btn" onClick={() => onSave(p)}>Zapisz</button>
        <button className="btn ghost" onClick={onClose}>Anuluj</button>
      </div>
    </Modal>
  );
}
