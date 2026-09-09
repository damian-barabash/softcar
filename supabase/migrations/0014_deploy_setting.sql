insert into public.settings(key, value, group_name, label)
values ('deploy',
        jsonb_build_object('function_url', 'https://zqslfrjikxfmcubewfmk.supabase.co/functions/v1/publish',
                           'repo', ''),
        'system', 'Publikowanie strony')
on conflict (key) do update set value = excluded.value;
