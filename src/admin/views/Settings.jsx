import React, { useState } from 'react';
import { getSettings, saveSetting } from '../lib';
import { useAsync, Loading, ErrorBox, Field, Text, Area } from '../ui.jsx';

/** Opis pol: klucz ustawienia -> lista pol formularza. Reszta trafia do trybu JSON. */
const FORMS = {
  company: {
    title: 'Dane firmy',
    fields: [
      ['name', 'Nazwa'], ['street', 'Ulica i numer'], ['zip', 'Kod pocztowy'], ['city', 'Miasto'],
      ['phone', 'Telefon (wyświetlany)'], ['phone_href', 'Telefon (odnośnik tel:)'],
      ['email', 'E-mail'], ['hours', 'Godziny otwarcia'], ['route_url', 'Odnośnik „Wyznacz trasę”'],
      ['map_lat', 'Szerokość geogr.'], ['map_lng', 'Długość geogr.'],
    ],
  },
  seo: { title: 'SEO strony głównej', fields: [['title', 'Tytuł'], ['description', 'Opis', 'area'], ['site_name', 'Nazwa serwisu']] },
  branding: { title: 'Logo i grafiki', fields: [['logo', 'Logo'], ['favicon', 'Favicon'], ['og_image', 'Obraz do social media'], ['banner', 'Domyślny baner podstron'], ['banner_alt', 'Opis banera']] },
  contact_form: {
    title: 'Formularz kontaktowy',
    fields: [['heading', 'Nagłówek'], ['lead', 'Tekst nad formularzem', 'area'], ['required_note', 'Informacja o polach wymaganych'],
      ['submit', 'Napis na przycisku'], ['success', 'Komunikat po wysłaniu'], ['error', 'Komunikat błędu'],
      ['rodo_html', 'Treść zgody RODO (HTML)', 'area']],
  },
};

export default function Settings({ toast }) {
  const { data, loading, error, reload } = useAsync(getSettings);
  if (loading) return <Loading />;
  const rows = data ?? [];

  return (
    <>
      <ErrorBox error={error} />
      <div className="topbar"><h1>Ustawienia</h1></div>
      <div className="warn">
        <strong>Do sprawdzenia z klientem:</strong> zgoda RODO oraz strony „Polityka prywatności”,
        „Polityka Cookies” i „Obowiązek informacyjny” przeniesione ze starej strony wskazują jako
        administratora danych <strong>KROPLA ZDROWIA sp. z o.o., ul. Strażacka 81, Bielsko-Biała</strong>,
        a nie Soft Car Service. To pozostałość po szablonie poprzedniej agencji.
      </div>
      {rows.map((s) => <Group key={s.key} row={s} toast={toast} reload={reload} />)}
    </>
  );
}

function Group({ row, toast, reload }) {
  const spec = FORMS[row.key];
  const [v, setV] = useState(row.value);
  const [raw, setRaw] = useState(false);
  const [text, setText] = useState(JSON.stringify(row.value, null, 2));

  const save = async () => {
    try {
      const value = raw ? JSON.parse(text) : v;
      await saveSetting(row.key, value);
      toast('Zapisano ustawienia');
      reload();
    } catch (e) { toast(e.message, 'err'); }
  };

  return (
    <div className="card">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <h2>{spec?.title ?? row.label ?? row.key}</h2>
        <button className="btn ghost sm" onClick={() => { setRaw(!raw); setText(JSON.stringify(v, null, 2)); }}>
          {raw ? 'Formularz' : 'Tryb zaawansowany (JSON)'}
        </button>
      </div>

      {raw || !spec ? (
        <textarea value={text} onChange={(e) => setText(e.target.value)} rows={10}
          style={{ fontFamily: 'ui-monospace, Menlo, monospace', fontSize: 12.5 }} spellCheck={false} />
      ) : (
        <div className="grid2">
          {spec.fields.map(([k, label, type]) => (
            <div key={k} style={type === 'area' ? { gridColumn: '1 / -1' } : undefined}>
              <Field label={label}>
                {type === 'area'
                  ? <Area value={v?.[k]} onChange={(x) => setV({ ...v, [k]: x })} rows={3} />
                  : <Text value={v?.[k] != null ? String(v[k]) : ''} onChange={(x) => setV({ ...v, [k]: x })} />}
              </Field>
            </div>
          ))}
        </div>
      )}
      <button className="btn" onClick={save}>Zapisz</button>
    </div>
  );
}
