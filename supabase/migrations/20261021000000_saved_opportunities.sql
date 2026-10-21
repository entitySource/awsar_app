-- Saved EduAnchors opportunities per account.
-- Run once: Supabase dashboard > SQL editor > paste > Run (or `supabase db push`).
-- Name and mobile live in auth user metadata, so no profiles table is needed.

create table if not exists public.saved_opportunities (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  opportunity_id text not null check (char_length(opportunity_id) between 1 and 200),
  created_at timestamptz not null default now(),
  primary key (user_id, opportunity_id)
);

alter table public.saved_opportunities enable row level security;

-- Each signed-in user sees and changes only their own rows.
create policy "Read own saved" on public.saved_opportunities
  for select to authenticated using ((select auth.uid()) = user_id);

create policy "Add own saved" on public.saved_opportunities
  for insert to authenticated with check ((select auth.uid()) = user_id);

create policy "Remove own saved" on public.saved_opportunities
  for delete to authenticated using ((select auth.uid()) = user_id);
