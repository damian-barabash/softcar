import React, { useState, useEffect, useCallback } from 'react';

export function Field({ label, hint, children }) {
  return (
    <label className="f">
      <span>{label} {hint && <small>— {hint}</small>}</span>
      {children}
    </label>
  );
}

export function Text({ value, onChange, ...rest }) {
  return <input type="text" value={value ?? ''} onChange={(e) => onChange(e.target.value)} {...rest} />;
}

export function Area({ value, onChange, rows = 4, ...rest }) {
  return <textarea rows={rows} value={value ?? ''} onChange={(e) => onChange(e.target.value)} {...rest} />;
}

export function Toggle({ value, onChange, label }) {
  return (
    <label className="f" style={{ display: 'flex', gap: 8, alignItems: 'center' }}>
      <input type="checkbox" checked={!!value} onChange={(e) => onChange(e.target.checked)} style={{ width: 16, height: 16 }} />
      <span style={{ margin: 0 }}>{label}</span>
    </label>
  );
}

export function Toast({ msg, kind, onDone }) {
  useEffect(() => {
    if (!msg) return;
    const t = setTimeout(onDone, kind === 'err' ? 6000 : 2500);
    return () => clearTimeout(t);
  }, [msg, kind, onDone]);
  if (!msg) return null;
  return <div className={`toast ${kind === 'err' ? 'err' : ''}`}>{msg}</div>;
}

export function Modal({ title, children, onClose, wide }) {
  useEffect(() => {
    const h = (e) => e.key === 'Escape' && onClose();
    document.addEventListener('keydown', h);
    return () => document.removeEventListener('keydown', h);
  }, [onClose]);
  return (
    <div className="modal-back" onMouseDown={(e) => e.target === e.currentTarget && onClose()}>
      <div className="modal" style={wide ? { maxWidth: 1100 } : undefined}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', gap: 16 }}>
          <h2>{title}</h2>
          <button className="btn ghost sm" onClick={onClose}>Zamknij</button>
        </div>
        {children}
      </div>
    </div>
  );
}

export function useAsync(fn, deps = []) {
  const [state, setState] = useState({ loading: true, data: null, error: null });
  const run = useCallback(() => {
    setState((s) => ({ ...s, loading: true }));
    fn()
      .then((data) => setState({ loading: false, data, error: null }))
      .catch((error) => setState({ loading: false, data: null, error }));
  }, deps); // eslint-disable-line react-hooks/exhaustive-deps
  useEffect(() => { run(); }, [run]);
  return { ...state, reload: run };
}

export function Loading() {
  return <div className="card muted">Wczytywanie…</div>;
}

export function ErrorBox({ error }) {
  if (!error) return null;
  return <div className="err-box">{error.message ?? String(error)}</div>;
}

/** Prosty edytor kolejnosci: strzalki gora/dol zamieniaja pole `sort`. */
export function orderTools(items, idx, onSwap) {
  return (
    <>
      <button className="btn ghost sm" disabled={idx === 0} onClick={() => onSwap(idx, idx - 1)} title="W górę">↑</button>
      <button className="btn ghost sm" disabled={idx === items.length - 1} onClick={() => onSwap(idx, idx + 1)} title="W dół">↓</button>
    </>
  );
}
