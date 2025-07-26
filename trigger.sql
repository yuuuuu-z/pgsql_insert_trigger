CREATE TABLE USERS(
  id uuid references auth.users not null primary key,
  email text
);

create or replace function public.insert_user_on_sign_up()
returns trigger as $$
begin 
  insert into public.users (id, email)
  values (new.id, new.email);
  return new;
end;
$$ language plpgsql security definer;

create trigger on_new_user
  after insert on auth.users
  for each row execute procedure public.insert_user_on_sign_up();