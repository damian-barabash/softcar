import React, { useState } from 'react';
import { list, update, insert, remove } from '../lib';
import { useAsync, Loading, ErrorBox, Field, Text, Toggle, Modal, orderTools } from '../ui.jsx';

export default function Menu({ toast }) {
  const { data, loading, error, reload } = useAsync(() => list('menu_items'));
  const [edit, setEdit] = useState(null);
  if (loading) return <Loading />;
  const rows = data ?? [];

  const Block = ({ location, title }) => {
    const roots = rows.filter((r) => r.location === location && !r.parent_id);
    const swap = async (a, b) => {
      await update('menu_items', roots[a].id, { sort: roots[b].sort });
      await update('menu_items', roots[b].id, { sort: roots[a].sort });
      reload();
    };
    return (
      <div className="card">
        <h2>{title}</h2>
        <table className="list">
          <thead><tr><th>Nazwa</th><th>Adres</th><th>Status</th><th className="right">Akcje</th></tr></thead>
          <tbody>
            {roots.map((m, i) => {
              const kids = rows.filter((r) => r.parent_id === m.id);
              return (
                <React.Fragment key={m.id}>
                  <tr>
                    <td><strong>{m.label}</strong></td>
                    <td className="muted">{m.href}</td>
                    <td><span className={`pill ${m.is_published ? 'on' : 'off'}`}>{m.is_published ? 'widoczna' : 'ukryta'}</span></td>
                    <td className="right"><div className="row-actions">
                      {orderTools(roots, i, swap)}
                      <button className="btn ghost sm" onClick={() => setEdit({ ...m })}>Edytuj</button>
                      <button className="btn ghost sm" onClick={() => setEdit({ location, parent_id: m.id, label: '', href: '/', sort: (kids.at(-1)?.sort ?? 0) + 10, is_published: true, target: '_self' })}>+ podpozycja</button>
                      <button className="btn danger sm" onClick={async () => { if (confirm(`Usunąć „${m.label}” wraz z podpozycjami?`)) { await remove('menu_items', m.id); reload(); } }}>Usuń</button>
                    </div></td>
                  </tr>
                  {kids.map((k) => (
                    <tr key={k.id}>
                      <td style={{ paddingLeft: 34 }} className="muted">↳ {k.label}</td>
                      <td className="muted">{k.href}</td>
                      <td><span className={`pill ${k.is_published ? 'on' : 'off'}`}>{k.is_published ? 'widoczna' : 'ukryta'}</span></td>
                      <td className="right"><div className="row-actions">
                        <button className="btn ghost sm" onClick={() => setEdit({ ...k })}>Edytuj</button>
                        <button className="btn danger sm" onClick={async () => { if (confirm('Usunąć podpozycję?')) { await remove('menu_items', k.id); reload(); } }}>Usuń</button>
                      </div></td>
                    </tr>
                  ))}
                </React.Fragment>
              );
            })}
          </tbody>
        </table>
        <button className="btn ghost sm" style={{ marginTop: 12 }} onClick={() => setEdit({ location, label: '', href: '/', sort: (roots.at(-1)?.sort ?? 0) + 10, is_published: true, target: '_self' })}>+ Dodaj pozycję</button>
      </div>
    );
  };

  return (
    <>
      <ErrorBox error={error} />
      <div className="topbar"><h1>Menu</h1></div>
      <Block location="header" title="Menu główne (nagłówek)" />
      <Block location="footer" title="Menu w stopce" />
      {edit && <MenuForm m={edit} onClose={() => setEdit(null)} onSave={async (v) => {
        const { id, ...rest } = v;
        id ? await update('menu_items', id, rest) : await insert('menu_items', rest);
        toast('Zapisano'); setEdit(null); reload();
      }} />}
    </>
  );
}

function MenuForm({ m, onSave, onClose }) {
  const [v, setV] = useState(m);
  const set = (k) => (x) => setV((o) => ({ ...o, [k]: x }));
  return (
    <Modal title="Pozycja menu" onClose={onClose}>
      <Field label="Nazwa"><Text value={v.label} onChange={set('label')} /></Field>
      <Field label="Adres" hint="np. /oferta lub https://…"><Text value={v.href} onChange={set('href')} /></Field>
      <Field label="Otwieranie">
        <select value={v.target} onChange={(e) => set('target')(e.target.value)}>
          <option value="_self">W tym samym oknie</option>
          <option value="_blank">W nowej karcie</option>
        </select>
      </Field>
      <Field label="Kolejność"><Text value={String(v.sort ?? 0)} onChange={(x) => set('sort')(parseInt(x || '0', 10))} /></Field>
      <Toggle value={v.is_published} onChange={set('is_published')} label="Pozycja widoczna" />
      <button className="btn" onClick={() => onSave(v)}>Zapisz</button>
    </Modal>
  );
}
