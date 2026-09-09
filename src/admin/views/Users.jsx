import React, { useState } from 'react';
import { list, update, remove, supabase } from '../lib';
import { useAsync, Loading, ErrorBox } from '../ui.jsx';

export default function Users({ toast, me }) {
  const { data, loading, error, reload } = useAsync(async () => ({
    admins: await list('admin_users', { order: 'created_at' }),
    legacy: await list('legacy_users', { order: 'id' }),
  }));
  const [tab, setTab] = useState('admins');
  if (loading) return <Loading />;

  return (
    <>
      <ErrorBox error={error} />
      <div className="topbar"><h1>Użytkownicy</h1></div>

      <div className="card" style={{ display: 'flex', gap: 8 }}>
        <button className={`btn ${tab === 'admins' ? '' : 'ghost'} sm`} onClick={() => setTab('admins')}>Panel ({data.admins.length})</button>
        <button className={`btn ${tab === 'legacy' ? '' : 'ghost'} sm`} onClick={() => setTab('legacy')}>Archiwum ze starej strony ({data.legacy.length})</button>
      </div>

      {tab === 'admins' ? (
        <div className="card">
          <div className="warn">
            Nowe konto zakłada się w panelu Supabase (<em>Authentication → Add user</em>). Po pierwszym logowaniu
            osoba pojawi się na tej liście automatycznie. Hasła nie są widoczne w tym panelu.
          </div>
          <table className="list">
            <thead><tr><th>E-mail</th><th>Imię i nazwisko</th><th>Rola</th><th>Od</th><th className="right">Akcje</th></tr></thead>
            <tbody>
              {data.admins.map((u) => (
                <tr key={u.id}>
                  <td>{u.email}{u.id === me?.id && <span className="muted"> — to Ty</span>}</td>
                  <td><input type="text" defaultValue={u.full_name ?? ''} onBlur={(e) => update('admin_users', u.id, { full_name: e.target.value })} /></td>
                  <td>
                    <select value={u.role} disabled={u.id === me?.id} onChange={async (e) => { await update('admin_users', u.id, { role: e.target.value }); toast('Zmieniono rolę'); reload(); }}>
                      <option value="owner">Właściciel</option>
                      <option value="editor">Redaktor</option>
                    </select>
                  </td>
                  <td className="muted">{new Date(u.created_at).toLocaleDateString('pl-PL')}</td>
                  <td className="right">
                    <button className="btn danger sm" disabled={u.id === me?.id} onClick={async () => {
                      if (!confirm(`Odebrać dostęp dla ${u.email}?`)) return;
                      await remove('admin_users', u.id); toast('Odebrano dostęp'); reload();
                    }}>Odbierz dostęp</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ) : (
        <div className="card">
          <div className="warn">
            To kopia listy kont ze starej strony (Joomla), przeniesiona w całości na życzenie klienta.
            <strong> Te konta nie mają dostępu do nowego panelu</strong> — służą wyłącznie jako archiwum.
            Zdecydowana większość to adresy poprzedniej agencji (@wenet.pl).
          </div>
          <table className="list">
            <thead><tr><th>#</th><th>Imię i nazwisko</th><th>Login</th><th>E-mail</th><th>Grupa</th><th>Ostatnie logowanie</th><th className="right"></th></tr></thead>
            <tbody>
              {data.legacy.map((u) => (
                <tr key={u.id}>
                  <td className="muted">{u.id}</td>
                  <td>{u.name}</td>
                  <td className="muted">{u.username}</td>
                  <td className="muted">{u.email}</td>
                  <td>{u.group_name}</td>
                  <td className="muted">{u.last_visit ? new Date(u.last_visit).toLocaleDateString('pl-PL') : '—'}</td>
                  <td className="right">
                    <button className="btn danger sm" onClick={async () => {
                      if (!confirm(`Usunąć wpis „${u.name}” z archiwum?`)) return;
                      await remove('legacy_users', u.id); reload();
                    }}>Usuń</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </>
  );
}
