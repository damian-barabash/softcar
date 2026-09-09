import React, { useState } from 'react';
import { list, uploadFile, deleteFile, update } from './lib';
import { Modal, useAsync, Loading, ErrorBox } from './ui.jsx';

export default function MediaPicker({ onPick, onClose }) {
  const { data, loading, error, reload } = useAsync(() => list('media', { order: 'created_at', asc: false }));
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState(null);

  const onFiles = async (files) => {
    setBusy(true); setErr(null);
    try {
      for (const f of files) await uploadFile(f);
      reload();
    } catch (e) { setErr(e); }
    setBusy(false);
  };

  return (
    <Modal title="Biblioteka plików" onClose={onClose} wide>
      <ErrorBox error={error || err} />
      <div style={{ display: 'flex', gap: 10, alignItems: 'center', marginBottom: 16 }}>
        <input type="file" multiple accept="image/*,application/pdf" onChange={(e) => onFiles([...e.target.files])} />
        {busy && <span className="muted">Wysyłanie…</span>}
      </div>
      {loading ? <Loading /> : (
        <div className="thumbs">
          {(data ?? []).map((m) => (
            <div className="thumb" key={m.id}>
              <img src={m.url} alt={m.alt ?? ''} onClick={() => onPick?.(m)} style={{ cursor: onPick ? 'pointer' : 'default' }} />
              <div className="meta">
                <input
                  type="text"
                  defaultValue={m.alt ?? ''}
                  placeholder="opis (alt)"
                  onBlur={(e) => update('media', m.id, { alt: e.target.value })}
                  style={{ padding: '3px 6px', fontSize: 12 }}
                />
                <button
                  className="btn danger sm"
                  onClick={async () => {
                    if (!confirm('Usunąć plik?')) return;
                    await deleteFile(m); reload();
                  }}
                >×</button>
              </div>
            </div>
          ))}
          {!(data ?? []).length && <p className="muted">Brak plików — wgraj pierwszy powyżej.</p>}
        </div>
      )}
    </Modal>
  );
}
