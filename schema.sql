-- Run once in Supabase: SQL Editor -> New query.
create table public.items (
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

alter table public.items enable row level security;

-- Each signed-in user only sees and changes their own rows.
create policy "own items" on public.items
  for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
