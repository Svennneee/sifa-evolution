-- ═══════════════════════════════════════════════════════════════
--  Sifa Evolution – Supabase-Setup
--  In Supabase: SQL Editor → New query → alles einfügen → Run
-- ═══════════════════════════════════════════════════════════════

create table if not exists public.sifa_items (
  room        text        not null,
  col         text        not null check (col in ('people','drinks','votes','comments','activity','options','venues')),
  id          text        not null check (char_length(id) between 1 and 120),
  data        jsonb       not null check (pg_column_size(data) < 8000),
  updated_at  timestamptz not null default now(),
  primary key (room, col, id)
);

-- Damit Lösch-Ereignisse live mit allen Feldern ankommen
alter table public.sifa_items replica identity full;

-- Row Level Security: Zugriff nur auf den Raum dieses Abends
alter table public.sifa_items enable row level security;

drop policy if exists "sifa lesen"     on public.sifa_items;
drop policy if exists "sifa anlegen"   on public.sifa_items;
drop policy if exists "sifa aendern"   on public.sifa_items;
drop policy if exists "sifa loeschen"  on public.sifa_items;

create policy "sifa lesen"    on public.sifa_items for select to anon, authenticated
  using (room = 'sifa-stuttgart-2026-11-25');
create policy "sifa anlegen"  on public.sifa_items for insert to anon, authenticated
  with check (room = 'sifa-stuttgart-2026-11-25');
create policy "sifa aendern"  on public.sifa_items for update to anon, authenticated
  using (room = 'sifa-stuttgart-2026-11-25') with check (room = 'sifa-stuttgart-2026-11-25');
create policy "sifa loeschen" on public.sifa_items for delete to anon, authenticated
  using (room = 'sifa-stuttgart-2026-11-25');

-- Live-Synchronisierung (Realtime) einschalten
do $$
begin
  alter publication supabase_realtime add table public.sifa_items;
exception when duplicate_object then null;
end $$;

-- ───────────────────────────────────────────────────────────────
--  Nach dem Abend alles löschen (bei Bedarf einzeln ausführen):
--  delete from public.sifa_items where room = 'sifa-stuttgart-2026-11-25';
-- ───────────────────────────────────────────────────────────────
