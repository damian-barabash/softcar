import React, { useState, useMemo } from 'react';
import { supabase, update, remove } from '../lib';
import { useAsync, Loading, ErrorBox, Modal, Area } from '../ui.jsx';

const STATUS = {
  nowy: 'Nowe',
  w_kontakcie: 'W kontakcie',
  wycena: 'Wycena',
  zamkniety: 'Zamknięte',
  spam: 'Spam',
};

export default function Leads({ toast }) {
  const { data, loading, error, reload } = useAsync(async () => {
    const { data, error } = await supabase.from('leads').select('*').order('created_at', { ascending: false });
    if (error) throw error;
    return data ?? [];
  });
  const [f, setF] = useState('all');
  const [open, setOpen] = useState(null);
  const rows = data ?? [];
  const shown = useMemo(() => (f === 'all' ? rows : rows.filter((r) => r.status === f)), [rows, f]);

  if (loading) return <Loading />;

  const csv = () => {
    const head = ['id', 'data', 'imie', 'email', 'telefon', 'temat', 'wiadomosc', 'status', 'notatka'];
    const esc = (v) => `"${String(v ?? '').replace(/"/g, '""')}"`;
    const body = shown.map((r) => [r.id, r.created_at, r.name, r.email, r.phone, r.topic, r.message, r.status, r.note].map(esc).join(','));
    const blob = new Blob(['﻿' + [head.join(','), ...body].join('\n')], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = `zgloszenia-${new Date().toISOString().slice(0, 10)}.csv`;
    a.click();
  };

  return (
    <>
      <ErrorBox error={error} />
      <div className="topbar">
        <h1>Zgłoszenia <span className="muted" style={{ fontSize: 15 }}>({rows.length})</span></h1>
        <div className="actions">
          <button className="btn ghost" onClick={csv}>Eksport CSV</button>
        </div>
      </div>

      <div className="card" style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
        <button className={`btn ${f === 'all' ? '' : 'ghost'} sm`} onClick={() => setF('all')}>Wszystkie ({rows.length})</button>
        {Object.entries(STATUS).map(([k, v]) => (
          <button key={k} className={`btn ${f === k ? '' : 'ghost'} sm`} onClick={() => setF(k)}>
            {v} ({rows.filter((r) => r.status === k).length})
          </button>
        ))}
      </div>

      <table className="list">
        <thead><tr><th>Data</th><th>Kto</th><th>Temat</th><th>Status</th><th className="right">Akcje</th></tr></thead>
        <tbody>
          {shown.map((r) => (
            <tr key={r.id}>
              <td className="muted" style={{ whiteSpace: 'nowrap' }}>{new Date(r.created_at).toLocaleString('pl-PL')}</td>
              <td>
                <strong>{r.name}</strong><br />
                <small className="muted"><a href={`mailto:${r.email}`}>{r.email}</a>{r.phone ? ` · ${r.phone}` : ''}</small>
              </td>
              <td>{r.topic}</td>
              <td>
                <select value={r.status} onChange={async (e) => { await update('leads', r.id, { status: e.target.value }); reload(); }}>
                  {Object.entries(STATUS).map(([k, v]) => <option key={k} value={k}>{v}</option>)}
                </select>
              </td>
              <td className="right"><div className="row-actions">
                <button className="btn ghost sm" onClick={() => setOpen(r)}>Otwórz</button>
                <button className="btn danger sm" onClick={async () => { if (confirm('Usunąć zgłoszenie?')) { await remove('leads', r.id); reload(); } }}>Usuń</button>
              </div></td>
            </tr>
          ))}
          {!shown.length && <tr><td colSpan={5} className="muted">Brak zgłoszeń w tym widoku.</td></tr>}
        </tbody>
      </table>

      {open && (
        <Modal title={`Zgłoszenie #${open.id}`} onClose={() => setOpen(null)}>
          <p><strong>{open.name}</strong><br />
            <a href={`mailto:${open.email}`}>{open.email}</a>{open.phone && <> · <a href={`tel:${open.phone}`}>{open.phone}</a></>}<br />
            <span className="muted">{new Date(open.created_at).toLocaleString('pl-PL')}</span>
          </p>
          <p><strong>Temat:</strong> {open.topic}</p>
          <p style={{ whiteSpace: 'pre-wrap', background: '#f5f7f9', padding: 14, borderRadius: 6 }}>{open.message}</p>
          <label className="f"><span>Notatka wewnętrzna</span>
            <Area value={open.note} onChange={(v) => setOpen({ ...open, note: v })} rows={3} />
          </label>
          <button className="btn" onClick={async () => {
            await update('leads', open.id, { note: open.note, status: open.status });
            toast('Zapisano notatkę'); setOpen(null); reload();
          }}>Zapisz</button>
        </Modal>
      )}
    </>
  );
}
