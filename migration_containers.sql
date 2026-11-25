-- Run once in Supabase SQL Editor if you already ran the first schema.sql.
-- Adds containers (Work, Personal, ...) and links items to them.
create table if not exists public.focus_containers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  created_at timestamptz not null default now()
);

alter table public.focus_containers enable row level security;

drop policy if exists "own focus containers" on public.focus_containers;
create policy "own focus containers" on public.focus_containers
  for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

grant select, insert, update, delete on public.focus_containers to authenticated;

alter table public.focus_items
  add column if not exists container_id uuid references public.focus_containers(id) on delete set null;
