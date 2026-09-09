import { createClient } from '@supabase/supabase-js';
import { SUPABASE_URL, SUPABASE_ANON_KEY } from '../lib/config';

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: { persistSession: true, autoRefreshToken: true, storageKey: 'softcar-admin' },
});

export const MEDIA_BUCKET = 'media';

export async function list(table, { order = 'sort', asc = true, filter } = {}) {
  let q = supabase.from(table).select('*');
  if (filter) for (const [k, v] of Object.entries(filter)) q = q.eq(k, v);
  if (order) q = q.order(order, { ascending: asc });
  const { data, error } = await q;
  if (error) throw error;
  return data ?? [];
}

export async function upsert(table, row) {
  const { data, error } = await supabase.from(table).upsert(row).select().single();
  if (error) throw error;
  await log(row.id ? 'update' : 'create', table, data?.id, row);
  return data;
}

export async function insert(table, row) {
  const { data, error } = await supabase.from(table).insert(row).select().single();
  if (error) throw error;
  await log('create', table, data?.id, row);
  return data;
}

export async function update(table, id, patch) {
  const { data, error } = await supabase.from(table).update(patch).eq('id', id).select().single();
  if (error) throw error;
  await log('update', table, id, patch);
  return data;
}

export async function remove(table, id) {
  const { error } = await supabase.from(table).delete().eq('id', id);
  if (error) throw error;
  await log('delete', table, id, null);
}

export async function getSettings() {
  const { data, error } = await supabase.from('settings').select('*').order('group_name');
  if (error) throw error;
  return data ?? [];
}

export async function saveSetting(key, value) {
  const { error } = await supabase.from('settings').update({ value, updated_at: new Date().toISOString() }).eq('key', key);
  if (error) throw error;
  await log('update', 'settings', key, value);
}

async function log(action, entity, entityId, payload) {
  try {
    const { data } = await supabase.auth.getUser();
    await supabase.from('audit_log').insert({
      actor: data?.user?.email ?? null,
      action, entity,
      entity_id: entityId != null ? String(entityId) : null,
      payload: payload && typeof payload === 'object' ? payload : null,
    });
  } catch {
    /* dziennik nie moze blokowac zapisu tresci */
  }
}

export async function uploadFile(file) {
  const safe = file.name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/[^a-z0-9.\-_]+/g, '-')
    .replace(/-+/g, '-');
  const path = `${new Date().getFullYear()}/${Date.now()}-${safe}`;
  const { error } = await supabase.storage.from(MEDIA_BUCKET).upload(path, file, {
    cacheControl: '31536000',
    upsert: false,
    contentType: file.type || undefined,
  });
  if (error) throw error;
  const { data } = supabase.storage.from(MEDIA_BUCKET).getPublicUrl(path);
  const row = await insert('media', {
    path,
    url: data.publicUrl,
    alt: '',
    size_bytes: file.size,
  });
  return row;
}

export async function deleteFile(row) {
  await supabase.storage.from(MEDIA_BUCKET).remove([row.path]);
  await remove('media', row.id);
}

/** Uruchamia przebudowe strony przez GitHub Actions (repository_dispatch). */
export async function publishSite() {
  const { data: s } = await supabase.from('settings').select('value').eq('key', 'deploy').single();
  const cfg = s?.value ?? {};
  if (!cfg.function_url) throw new Error('Publikowanie nie jest jeszcze skonfigurowane (ustawienia → deploy).');
  const { data: session } = await supabase.auth.getSession();
  const r = await fetch(cfg.function_url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${session?.session?.access_token ?? ''}`,
    },
    body: JSON.stringify({ reason: 'panel' }),
  });
  if (!r.ok) throw new Error(`Publikacja nie powiodła się (${r.status})`);
  return r.json();
}

export const PL = {
  saved: 'Zapisano',
  error: 'Coś poszło nie tak',
  confirmDelete: 'Na pewno usunąć? Tej operacji nie można cofnąć.',
};
