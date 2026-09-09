import React, { useState } from 'react';
import { supabase, publishSite } from '../lib';
import { useAsync, Loading } from '../ui.jsx';

export default function Dashboard({ toast, go }) {
  const { data, loading } = useAsync(async () => {
    const count = async (t, filter) => {
      let q = supabase.from(t).select('id', { count: 'exact', head: true });
      if (filter) for (const [k, v] of Object.entries(filter)) q = q.eq(k, v);
      const { count: c } = await q;
      return c ?? 0;
    };
    const { data: last } = await supabase.from('leads').select('*').order('created_at', { ascending: false }).limit(5);
    return {
      pages: await count('pages'),
      leadsNew: await count('leads', { status: 'nowy' }),
      leads: await count('leads'),
      gallery: await count('gallery_images'),
      last: last ?? [],
    };
  });
  const [busy, setBusy] = useState(false);
  if (loading) return <Loading />;

  const publish = async () => {
    setBusy(true);
    try { await publishSite(); toast('Publikacja uruchomiona — strona odświeży się za ok. minutę'); }
    catch (e) { toast(e.message, 'err'); }
    setBusy(false);
  };

  const Tile = ({ n, label, onClick, accent }) => (
    <div className="card" style={{ cursor: onClick ? 'pointer' : 'default', margin: 0 }} onClick={onClick}>
      <div style={{ fontSize: 30, fontWeight: 700, color: accent ? 'var(--acc)' : 'var(--ink)' }}>{n}</div>
      <div className="muted">{label}</div>
    </div>
  );

  return (
    <>
      <div className="topbar">
        <h1>Pulpit</h1>
        <div className="actions">
          <a className="btn ghost" href="/" target="_blank" rel="noreferrer">Zobacz stronę</a>
          <button className="btn" onClick={publish} disabled={busy}>{busy ? 'Publikowanie…' : 'Opublikuj zmiany'}</button>
        </div>
      </div>

      <div className="warn">
        Zmiany treści zapisują się od razu w bazie. Aby pojawiły się na stronie publicznej,
        kliknij <strong>„Opublikuj zmiany”</strong> — strona przebuduje się automatycznie (ok. 1 minuty).
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit,minmax(180px,1fr))', gap: 16, marginBottom: 16 }}>
        <Tile n={data.leadsNew} label="Nowe zgłoszenia" accent onClick={() => go('leads')} />
        <Tile n={data.leads} label="Zgłoszenia łącznie" onClick={() => go('leads')} />
        <Tile n={data.pages} label="Strony" onClick={() => go('pages')} />
        <Tile n={data.gallery} label="Zdjęcia w galerii" onClick={() => go('gallery')} />
      </div>

      <div className="card">
        <h2>Ostatnie zgłoszenia</h2>
        <table className="list">
          <tbody>
            {data.last.map((l) => (
              <tr key={l.id}>
                <td className="muted" style={{ whiteSpace: 'nowrap' }}>{new Date(l.created_at).toLocaleDateString('pl-PL')}</td>
                <td><strong>{l.name}</strong> — {l.topic}</td>
                <td><span className={`pill ${l.status}`}>{l.status}</span></td>
              </tr>
            ))}
            {!data.last.length && <tr><td className="muted">Brak zgłoszeń.</td></tr>}
          </tbody>
        </table>
      </div>
    </>
  );
}
