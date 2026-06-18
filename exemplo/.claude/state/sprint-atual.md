# Sprint Atual

> Fonte de verdade da Sprint corrente. Preenchido por /sprint-planejar (subagente
> arquiteto). Enquanto não houver a flag `sprint-aprovada`, código em src/ está
> bloqueado pelo hook gate-bloqueio-codigo.sh.

**Sprint 1 — KPI de Faturamento do Dia** · Fase: Planejamento · Status: **GATE 2 — aguardando aprovação**

> ⚠️ Este é um exemplo ilustrativo. A Sprint está parada no GATE 2: como `state/sprint-aprovada`
> não existe, qualquer escrita em `frontend/src` ou `backend/src` seria **bloqueada** pelo hook.

---

## 1. Documento da Sprint

- **Objetivo:** Entregar a primeira fatia vertical de valor — um card de KPI no dashboard
  que mostra o **faturamento líquido do dia atual**, do backend ao frontend.

- **Escopo incluído:**
  1. Endpoint `GET /api/v1/kpis/faturamento-dia` que retorna `{ data, valorLiquido, moeda }`.
  2. Use case `ObterFaturamentoDoDia` no backend (Clean Arch), com port de repositório.
  3. Card de KPI no dashboard (frontend) consumindo o endpoint via hook de React Query.

- **Escopo EXPLICITAMENTE fora (limite duro):**
  - Qualquer outro KPI (ticket médio, comparação YoY, projeção) — vira Sprint própria.
  - Filtros (período, canal) — fora desta fatia.
  - Gráfico de evolução — só o card numérico nesta Sprint.
  - Autenticação/autorização do endpoint — assume-se a já existente.

- **Premissas:** existe uma fonte de pedidos com `status` e `valorLiquido`; "do dia" = data atual do servidor.

- **Dependências:** aprovação humana via `/sprint-aprovar` para iniciar a implementação.

---

## 2. Histórias de usuário

- **H1 —** Como **gestor da loja**, quero ver o **faturamento líquido de hoje** num card no
  topo do dashboard, para acompanhar a venda do dia em tempo real.

---

## 3. Tasks técnicas (por história)

### H1 — Card de faturamento do dia
- [ ] **BE** — `domain`: value object `Dinheiro` (valor + moeda, imutável e auto-validado).
- [ ] **BE** — `application`: use case `ObterFaturamentoDoDia` + port `PedidoRepository.somarLiquidoPorData`.
- [ ] **BE** — `interfaces`: controller + rota `GET /api/v1/kpis/faturamento-dia` + DTO de resposta.
- [ ] **BE** — testes do use case (caminho feliz + dia sem vendas → zero).
- [ ] **FE** — `features/dashboard/api`: hook `useFaturamentoDia()` (React Query).
- [ ] **FE** — `features/dashboard/components`: `<CardFaturamentoDia />` (loading/erro/empty tratados).
- [ ] **FE** — montar o card no topo da página do dashboard.

---

## 4. Critérios de aceite

- [ ] `GET /api/v1/kpis/faturamento-dia` responde `{ data, valorLiquido, moeda }` tipado.
- [ ] Dia sem vendas retorna `valorLiquido: 0` (não erro).
- [ ] O card mostra estados de **loading** e **erro**; nunca assume sucesso silencioso.
- [ ] Nenhum valor hardcoded no front; cores/tipografia vêm do `theme/`.
- [ ] Nenhum outro KPI ou filtro foi implementado (escopo futuro não vazou).

## Definition of Done
- [ ] Critérios de aceite atendidos.
- [ ] `npm run typecheck` + `npm run lint` passando (frontend e backend).
- [ ] Regra de dependência do backend respeitada (domínio sem framework/HTTP).
- [ ] Revisado via /sprint-revisar (revisor-qa).
