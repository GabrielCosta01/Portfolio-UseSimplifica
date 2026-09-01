-- ============================================================
-- Tabela de leads do site usesimplifica.com.br
-- Rode no Supabase → SQL Editor → New query → Run
--
-- Projeto: jziresgmigokrtkujlvk (o mesmo do CRM)
-- Nome com sufixo _site para não colidir com o que o CRM criar depois.
-- ============================================================

create table if not exists public.leads_site (
  id          uuid primary key default gen_random_uuid(),
  criado_em   timestamptz not null default now(),
  nome        text not null,
  whatsapp    text not null,
  perfil      text,                 -- empresa | gestor
  necessidade text,                 -- landing-page | cardapio | catalogo | links | outro
  mensagem    text,
  origem      text,                 -- página de onde veio
  utm         jsonb                 -- utm_source, utm_medium, utm_campaign, gclid
);

create index if not exists leads_site_criado_em_idx
  on public.leads_site (criado_em desc);

-- ------------------------------------------------------------
-- SEGURANÇA
--
-- A chave anônima fica visível no código-fonte da página — é assim
-- que ela funciona. Por isso o RLS precisa permitir APENAS inserir.
-- Sem política de select, ninguém com essa chave consegue ler os
-- leads: só quem entra no painel do Supabase ou usa a service role.
-- ------------------------------------------------------------

alter table public.leads_site enable row level security;

drop policy if exists "site pode inserir lead" on public.leads_site;
create policy "site pode inserir lead"
  on public.leads_site
  for insert
  to anon
  with check (true);

-- Nenhuma política de SELECT, UPDATE ou DELETE para anon: proposital.

-- ------------------------------------------------------------
-- Conferência: as duas linhas abaixo devem retornar
--   insert = true, select = false
-- ------------------------------------------------------------
-- set role anon;
-- select has_table_privilege('public.leads_site', 'insert') as insert_ok,
--        has_table_privilege('public.leads_site', 'select') as select_ok;
-- reset role;
