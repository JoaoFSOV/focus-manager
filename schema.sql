-- Run once in Supabase: SQL Editor -> New query.
create table public.focus_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title text not null,
  status text not null default 'idea' check (status in ('idea', 'active', 'stalled')),
  done boolean not null default false,
  done_at timestamptz,
  next text not null default '',
  subs jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

alter table public.focus_items enable row level security;

-- Each signed-in user only sees and changes their own rows.
create policy "own focus items" on public.focus_items
  for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- Newer Supabase projects do not expose new tables to the Data API automatically.
grant usage on schema public to authenticated;
grant select, insert, update, delete on public.focus_items to authenticated;

-- Containers: run migration_containers.sql after this file (fresh install or not).
