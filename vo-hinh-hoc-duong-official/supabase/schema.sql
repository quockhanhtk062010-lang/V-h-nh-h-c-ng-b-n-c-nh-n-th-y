create table if not exists public.mood_checkins(id uuid primary key default gen_random_uuid(),user_id uuid not null references auth.users(id) on delete cascade,mood text not null check(mood in ('Rất ổn','Khá ổn','Bình thường','Hơi chênh vênh','Khó gọi tên')),note text not null default '' check(char_length(note)<=1000),created_at timestamptz not null default now());
create table if not exists public.journal_entries(id uuid primary key default gen_random_uuid(),user_id uuid not null references auth.users(id) on delete cascade,title text not null check(char_length(title) between 1 and 100),body text not null check(char_length(body) between 1 and 10000),created_at timestamptz not null default now());
create index if not exists mood_user_idx on public.mood_checkins(user_id,created_at desc);create index if not exists journal_user_idx on public.journal_entries(user_id,created_at desc);
alter table public.mood_checkins enable row level security;alter table public.journal_entries enable row level security;
drop policy if exists mood_read_own on public.mood_checkins;create policy mood_read_own on public.mood_checkins for select to authenticated using(auth.uid()=user_id);
drop policy if exists mood_add_own on public.mood_checkins;create policy mood_add_own on public.mood_checkins for insert to authenticated with check(auth.uid()=user_id);
drop policy if exists journal_read_own on public.journal_entries;create policy journal_read_own on public.journal_entries for select to authenticated using(auth.uid()=user_id);
drop policy if exists journal_add_own on public.journal_entries;create policy journal_add_own on public.journal_entries for insert to authenticated with check(auth.uid()=user_id);
drop policy if exists journal_delete_own on public.journal_entries;create policy journal_delete_own on public.journal_entries for delete to authenticated using(auth.uid()=user_id);
-- Chat history is not stored in the database.
