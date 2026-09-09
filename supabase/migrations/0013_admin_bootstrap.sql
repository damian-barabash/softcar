delete from public.leads where email = 'dmytrii.barabash@greywolfgroup.pl' and topic = 'Test formularza';

-- Kazde konto zalozone w Supabase Auth staje sie redaktorem CMS.
-- Pierwsze konto dostaje role wlasciciela (moze zarzadzac uzytkownikami).
create or replace function public.handle_new_admin()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.admin_users (id, email, full_name, role)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'full_name', split_part(new.email, '@', 1)),
    case when (select count(*) from public.admin_users) = 0 then 'owner' else 'editor' end
  )
  on conflict (id) do nothing;
  return new;
end $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_admin();

-- kubelek na pliki wgrywane z panelu
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('media', 'media', true, 10485760,
        array['image/jpeg','image/png','image/webp','image/gif','image/svg+xml','application/pdf'])
on conflict (id) do update set public = true, file_size_limit = 10485760;

drop policy if exists media_public_read on storage.objects;
create policy media_public_read on storage.objects
  for select using (bucket_id = 'media');

drop policy if exists media_admin_write on storage.objects;
create policy media_admin_write on storage.objects
  for all to authenticated
  using (bucket_id = 'media' and public.is_admin())
  with check (bucket_id = 'media' and public.is_admin());
