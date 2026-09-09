import React, { useEffect, useState, useCallback } from 'react';
import { supabase } from './lib';
import { Toast } from './ui.jsx';
import Dashboard from './views/Dashboard.jsx';
import Pages from './views/Pages.jsx';
import Home from './views/Home.jsx';
import Menu from './views/Menu.jsx';
import Gallery from './views/Gallery.jsx';
import Leads from './views/Leads.jsx';
import Settings from './views/Settings.jsx';
import Users from './views/Users.jsx';
import MediaPicker from './MediaPicker.jsx';
import './styles.css';

const NAV = [
  ['dash', 'Pulpit'],
  ['home', 'Strona główna'],
  ['pages', 'Strony'],
  ['menu', 'Menu'],
  ['gallery', 'Galeria'],
  ['leads', 'Zgłoszenia'],
  ['settings', 'Ustawienia'],
  ['users', 'Użytkownicy'],
];

export default function App() {
  const [session, setSession] = useState(undefined);
  const [me, setMe] = useState(null);
  const [route, setRoute] = useState(() => (location.hash || '#dash').slice(1));
  const [toast, setToast] = useState({ msg: '', kind: '' });
  const [media, setMedia] = useState(false);

  const notify = useCallback((msg, kind = 'ok') => setToast({ msg, kind }), []);

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => setSession(data.session));
    const { data: sub } = supabase.auth.onAuthStateChange((_e, s) => setSession(s));
    return () => sub.subscription.unsubscribe();
  }, []);

  useEffect(() => {
    if (!session) { setMe(null); return; }
    supabase.from('admin_users').select('*').eq('id', session.user.id).maybeSingle()
      .then(({ data }) => setMe(data));
  }, [session]);

  useEffect(() => {
    const h = () => setRoute((location.hash || '#dash').slice(1));
    window.addEventListener('hashchange', h);
    document.body.classList.add('sc-admin');
    return () => window.removeEventListener('hashchange', h);
  }, []);

  if (session === undefined) return <div className="login-wrap"><p>Wczytywanie…</p></div>;
  if (!session) return <Login notify={notify} toast={toast} setToast={setToast} />;

  if (me === null) {
    return (
      <div className="login-wrap">
        <div className="login-card">
          <h1>Brak uprawnień</h1>
          <p className="sub">Konto {session.user.email} nie ma dostępu do panelu.</p>
          <button className="btn ghost" onClick={() => supabase.auth.signOut()}>Wyloguj</button>
        </div>
      </div>
    );
  }

  const go = (r) => { location.hash = '#' + r; };
  const V = { dash: Dashboard, home: Home, pages: Pages, menu: Menu, gallery: Gallery, leads: Leads, settings: Settings, users: Users }[route] ?? Dashboard;

  return (
    <div className="layout">
      <aside className="side">
        <div className="brand">
          <img src="/images/design/logo.webp" alt="Soft Car Service" />
        </div>
        <nav>
          {NAV.map(([k, label]) => (
            <a key={k} href={`#${k}`} className={route === k ? 'on' : ''}>{label}</a>
          ))}
          <a href="#media" onClick={(e) => { e.preventDefault(); setMedia(true); }}>Pliki</a>
        </nav>
        <div className="foot">
          {me.email}<br />
          <span className="muted">{me.role === 'owner' ? 'właściciel' : 'redaktor'}</span><br />
          <button className="btn ghost sm" style={{ marginTop: 10 }} onClick={() => supabase.auth.signOut()}>Wyloguj</button>
        </div>
      </aside>
      <main className="main">
        <V toast={notify} go={go} me={me} />
      </main>
      {media && <MediaPicker onClose={() => setMedia(false)} />}
      <Toast msg={toast.msg} kind={toast.kind} onDone={() => setToast({ msg: '', kind: '' })} />
    </div>
  );
}

function Login({ toast, setToast }) {
  const [email, setEmail] = useState('');
  const [pass, setPass] = useState('');
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState('');

  const submit = async (e) => {
    e.preventDefault();
    setBusy(true); setErr('');
    const { error } = await supabase.auth.signInWithPassword({ email: email.trim(), password: pass });
    if (error) setErr(error.message === 'Invalid login credentials' ? 'Nieprawidłowy e-mail lub hasło.' : error.message);
    setBusy(false);
  };

  const reset = async () => {
    if (!email.trim()) return setErr('Podaj najpierw swój e-mail.');
    const { error } = await supabase.auth.resetPasswordForEmail(email.trim(), { redirectTo: location.origin + '/admin/' });
    setErr(error ? error.message : '');
    if (!error) setToast({ msg: 'Wysłaliśmy link do zmiany hasła.', kind: 'ok' });
  };

  return (
    <div className="login-wrap">
      <form className="login-card" onSubmit={submit}>
        <h1>Panel Soft Car Service</h1>
        <p className="sub">Zaloguj się, aby zarządzać treścią strony.</p>
        {err && <div className="err-box">{err}</div>}
        <label className="f"><span>E-mail</span>
          <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} autoComplete="username" required />
        </label>
        <label className="f"><span>Hasło</span>
          <input type="password" value={pass} onChange={(e) => setPass(e.target.value)} autoComplete="current-password" required />
        </label>
        <button className="btn" style={{ width: '100%', justifyContent: 'center' }} disabled={busy}>
          {busy ? 'Logowanie…' : 'Zaloguj się'}
        </button>
        <p style={{ marginBottom: 0, marginTop: 14, textAlign: 'center' }}>
          <button type="button" className="btn ghost sm" onClick={reset}>Nie pamiętam hasła</button>
        </p>
      </form>
      <Toast msg={toast.msg} kind={toast.kind} onDone={() => setToast({ msg: '', kind: '' })} />
    </div>
  );
}
