import React, { useState } from 'react';
import { list, update, insert, remove, uploadFile } from '../lib';
import { useAsync, Loading, ErrorBox, orderTools } from '../ui.jsx';

export default function Gallery({ toast }) {
  const { data, loading, error, reload } = useAsync(() => list('gallery_images'));
  const [busy, setBusy] = useState(false);
  if (loading) return <Loading />;
  const rows = data ?? [];
  const swap = async (a, b) => {
    await update('gallery_images', rows[a].id, { sort: rows[b].sort });
    await update('gallery_images', rows[b].id, { sort: rows[a].sort });
    reload();
  };

  const add = async (files) => {
    setBusy(true);
    try {
      let sort = (rows.at(-1)?.sort ?? 0) + 10;
      for (const f of files) {
        const m = await uploadFile(f);
        await insert('gallery_images', { url: m.url, thumb: m.url, alt: f.name.replace(/\.[^.]+$/, ''), sort });
        sort += 10;
      }
      toast('Dodano zdjęcia'); reload();
    } catch (e) { toast(e.message, 'err'); }
    setBusy(false);
  };

  return (
    <>
      <ErrorBox error={error} />
      <div className="topbar">
        <h1>Galeria</h1>
        <div className="actions">
          <label className="btn">
            + Dodaj zdjęcia
            <input type="file" multiple accept="image/*" style={{ display: 'none' }} onChange={(e) => add([...e.target.files])} />
          </label>
        </div>
      </div>
      <div className="card">
        <p className="muted">Galeria pokazuje się na stronie <strong>O nas</strong>. {busy && 'Wysyłanie…'}</p>
        <table className="list">
          <thead><tr><th>Zdjęcie</th><th>Opis (alt)</th><th className="right">Akcje</th></tr></thead>
          <tbody>
            {rows.map((g, i) => (
              <tr key={g.id}>
                <td><img src={g.thumb ?? g.url} alt="" style={{ height: 54, borderRadius: 4 }} /></td>
                <td><input type="text" defaultValue={g.alt ?? ''} onBlur={(e) => update('gallery_images', g.id, { alt: e.target.value })} /></td>
                <td className="right"><div className="row-actions">
                  {orderTools(rows, i, swap)}
                  <button className="btn danger sm" onClick={async () => { if (confirm('Usunąć zdjęcie z galerii?')) { await remove('gallery_images', g.id); reload(); } }}>Usuń</button>
                </div></td>
              </tr>
            ))}
            {!rows.length && <tr><td colSpan={3} className="muted">Galeria jest pusta.</td></tr>}
          </tbody>
        </table>
      </div>
    </>
  );
}
