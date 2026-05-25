-- Supabase SQL para la webapp Control Bankroll 007 Picks

create table if not exists public.bets (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  fecha date not null,
  tipo text not null check (tipo in ('simple', 'sistema', 'combinada')),
  partido text not null,
  pick text not null,
  cuota numeric,
  stake numeric not null default 0,
  resultado text not null default 'pendiente' check (resultado in ('pendiente', 'ganada', 'perdida', 'anulada')),
  retorno numeric,
  notas text
);

alter table public.bets enable row level security;

-- Para uso privado simple desde Netlify.
-- OJO: permite leer/escribir usando la anon key del proyecto.
-- Si publicas la URL, cualquiera podría escribir. Para uso personal privado está bien.
create policy "allow anon select bets"
on public.bets for select
to anon
using (true);

create policy "allow anon insert bets"
on public.bets for insert
to anon
with check (true);

create policy "allow anon update bets"
on public.bets for update
to anon
using (true)
with check (true);

create policy "allow anon delete bets"
on public.bets for delete
to anon
using (true);
