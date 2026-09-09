import React, { useRef, useEffect, useState } from 'react';
import MediaPicker from './MediaPicker.jsx';

/**
 * Edytor tresci oparty o contenteditable.
 * Wybor swiadomy: tresci przeniesione ze starego serwisu zawieraja siatke Bootstrapa
 * i style inline. Edytory ze wlasnym schematem (TipTap/ProseMirror) wycielyby te znaczniki
 * przy pierwszym zapisie. Tutaj przegladarka edytuje istniejacy HTML w miejscu,
 * a tryb "Kod HTML" daje pelna kontrole.
 */
export default function Editor({ value, onChange }) {
  const ref = useRef(null);
  const [mode, setMode] = useState('visual');
  const [src, setSrc] = useState(value ?? '');
  const [picker, setPicker] = useState(false);
  const skip = useRef(false);

  useEffect(() => {
    if (mode === 'visual' && ref.current && !skip.current && ref.current.innerHTML !== (value ?? '')) {
      ref.current.innerHTML = value ?? '';
    }
    skip.current = false;
  }, [value, mode]);

  useEffect(() => { setSrc(value ?? ''); }, [value]);

  const push = () => {
    if (!ref.current) return;
    skip.current = true;
    onChange(ref.current.innerHTML);
  };

  const cmd = (command, arg) => {
    ref.current?.focus();
    document.execCommand(command, false, arg);
    push();
  };

  const wrapBlock = (tag) => {
    ref.current?.focus();
    document.execCommand('formatBlock', false, tag);
    push();
  };

  const insertHtml = (html) => {
    ref.current?.focus();
    document.execCommand('insertHTML', false, html);
    push();
  };

  const addLink = () => {
    const url = prompt('Adres odnośnika (np. /kontakt lub https://…)');
    if (url) cmd('createLink', url);
  };

  const addTable = () => {
    const cols = parseInt(prompt('Ile kolumn?', '2') ?? '0', 10);
    const rows = parseInt(prompt('Ile wierszy (bez nagłówka)?', '3') ?? '0', 10);
    if (!cols || !rows) return;
    const th = Array.from({ length: cols }, (_, i) => `<th>Kolumna ${i + 1}</th>`).join('');
    const tr = Array.from({ length: rows }, () => `<tr>${'<td>&nbsp;</td>'.repeat(cols)}</tr>`).join('');
    insertHtml(`<table class="table"><tbody><tr>${th}</tr>${tr}</tbody></table><p>&nbsp;</p>`);
  };

  const tableOp = (op) => {
    const sel = window.getSelection();
    const cell = sel?.anchorNode instanceof Element
      ? sel.anchorNode.closest('td,th')
      : sel?.anchorNode?.parentElement?.closest('td,th');
    if (!cell) return alert('Ustaw kursor w komórce tabeli.');
    const row = cell.parentElement;
    const table = cell.closest('table');
    const idx = [...row.children].indexOf(cell);
    if (op === 'row+') {
      const clone = row.cloneNode(true);
      [...clone.children].forEach((c) => { c.innerHTML = '&nbsp;'; });
      row.after(clone);
    } else if (op === 'row-') {
      if (row.parentElement.children.length > 1) row.remove();
    } else if (op === 'col+') {
      [...table.querySelectorAll('tr')].forEach((r) => {
        const c = document.createElement(r.children[idx]?.tagName === 'TH' ? 'th' : 'td');
        c.innerHTML = '&nbsp;';
        r.children[idx]?.after(c);
      });
    } else if (op === 'col-') {
      [...table.querySelectorAll('tr')].forEach((r) => r.children[idx]?.remove());
    }
    push();
  };

  const B = ({ on, children, ...rest }) => (
    <button type="button" className={on ? 'on' : ''} {...rest}>{children}</button>
  );

  return (
    <div className="editor">
      <div className="tools">
        <B on={mode === 'visual'} onClick={() => { setMode('visual'); }}>Wizualnie</B>
        <B on={mode === 'src'} onClick={() => { setMode('src'); setSrc(value ?? ''); }}>Kod HTML</B>
        {mode === 'visual' && (
          <>
            <span className="sep" />
            <B onClick={() => cmd('bold')} title="Pogrubienie"><strong>B</strong></B>
            <B onClick={() => cmd('italic')} title="Kursywa"><em>I</em></B>
            <B onClick={() => cmd('underline')} title="Podkreślenie"><u>U</u></B>
            <span className="sep" />
            <B onClick={() => wrapBlock('h2')}>H2</B>
            <B onClick={() => wrapBlock('h3')}>H3</B>
            <B onClick={() => wrapBlock('p')}>Akapit</B>
            <span className="sep" />
            <B onClick={() => cmd('insertUnorderedList')} title="Lista punktowana">• Lista</B>
            <B onClick={() => cmd('insertOrderedList')} title="Lista numerowana">1. Lista</B>
            <span className="sep" />
            <B onClick={addLink}>Odnośnik</B>
            <B onClick={() => cmd('unlink')}>Usuń odnośnik</B>
            <B onClick={() => setPicker(true)}>Obraz</B>
            <span className="sep" />
            <B onClick={addTable}>Tabela</B>
            <B onClick={() => tableOp('row+')} title="Dodaj wiersz">+wiersz</B>
            <B onClick={() => tableOp('row-')} title="Usuń wiersz">−wiersz</B>
            <B onClick={() => tableOp('col+')} title="Dodaj kolumnę">+kol.</B>
            <B onClick={() => tableOp('col-')} title="Usuń kolumnę">−kol.</B>
            <span className="sep" />
            <B onClick={() => cmd('removeFormat')}>Wyczyść styl</B>
            <B onClick={() => cmd('undo')}>Cofnij</B>
            <B onClick={() => cmd('redo')}>Ponów</B>
          </>
        )}
      </div>

      {mode === 'visual' ? (
        <div
          className="area"
          ref={ref}
          contentEditable
          suppressContentEditableWarning
          onInput={push}
          onBlur={push}
          onPaste={(e) => {
            // wklejamy jako czysty tekst, zeby nie wciagac stylow z Worda
            e.preventDefault();
            const text = e.clipboardData.getData('text/plain');
            document.execCommand('insertText', false, text);
          }}
        />
      ) : (
        <textarea
          className="src"
          value={src}
          onChange={(e) => { setSrc(e.target.value); onChange(e.target.value); }}
          spellCheck={false}
        />
      )}

      {picker && (
        <MediaPicker
          onClose={() => setPicker(false)}
          onPick={(m) => {
            insertHtml(`<img src="${m.url}" alt="${(m.alt ?? '').replace(/"/g, '&quot;')}" loading="lazy">`);
            setPicker(false);
          }}
        />
      )}
    </div>
  );
}
