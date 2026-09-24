-- Valknut Gestión: tablas y seguridad.
-- Pegar todo en Supabase → SQL Editor → New query → Run.

-- 1) Datos (pedidos, clientes, productos, telas y ajustes)
create table if not exists public.registros (
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  tipo       text not null,
  id         text not null,
  data       jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, tipo, id)
);

alter table public.registros enable row level security;

create policy "registros: leer propios"   on public.registros for select to authenticated using (auth.uid() = user_id);
create policy "registros: crear propios"  on public.registros for insert to authenticated with check (auth.uid() = user_id);
create policy "registros: editar propios" on public.registros for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "registros: borrar propios" on public.registros for delete to authenticated using (auth.uid() = user_id);

create or replace function public.registros_touch() returns trigger
language plpgsql as $$ begin new.updated_at = now(); return new; end $$;

drop trigger if exists registros_touch on public.registros;
create trigger registros_touch before update on public.registros
for each row execute function public.registros_touch();

-- Sincronización en tiempo real entre dispositivos
alter publication supabase_realtime add table public.registros;

-- 2) Archivos (diseños, comprobantes, desgloses) en un depósito privado
insert into storage.buckets (id, name, public)
values ('adjuntos', 'adjuntos', false)
on conflict (id) do nothing;

create policy "adjuntos: leer propios"   on storage.objects for select to authenticated
  using (bucket_id = 'adjuntos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "adjuntos: subir propios"  on storage.objects for insert to authenticated
  with check (bucket_id = 'adjuntos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "adjuntos: editar propios" on storage.objects for update to authenticated
  using (bucket_id = 'adjuntos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "adjuntos: borrar propios" on storage.objects for delete to authenticated
  using (bucket_id = 'adjuntos' and (storage.foldername(name))[1] = auth.uid()::text);
