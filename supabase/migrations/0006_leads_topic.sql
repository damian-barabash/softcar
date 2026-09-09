alter table public.leads add column if not exists topic text;

update public.settings set value = value || jsonb_build_object(
  'fields', jsonb_build_array(
    jsonb_build_object('name','name','label','Imię i nazwisko','type','text','required',true),
    jsonb_build_object('name','email','label','E-mail','type','email','required',true),
    jsonb_build_object('name','phone','label','Telefon','type','tel','required',false),
    jsonb_build_object('name','topic','label','Temat wiadomości','type','text','required',true),
    jsonb_build_object('name','message','label','Wiadomość','type','textarea','required',true)
  ),
  'submit','Wyślij',
  'error','Nie udało się wysłać wiadomości. Spróbuj ponownie lub zadzwoń do nas.',
  'required_note','(*) - Pola oznaczone gwiazdką, są wymagane.',
  'heading','Formularz kontaktowy',
  'lead','Zachęcamy do skorzystania z formularza kontaktowego znajdującego się obok.'
) where key = 'contact_form';
