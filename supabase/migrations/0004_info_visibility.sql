alter table public.info_boxes add column if not exists visibility text not null default 'all'
  check (visibility in ('all','mobile','desktop'));
update public.info_boxes set visibility='mobile' where image is not null;
