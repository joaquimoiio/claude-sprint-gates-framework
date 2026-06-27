# Sprint 1 — KPI de Faturamento do Dia

> **Status: 🔵 Em andamento** · parada no GATE 2 (aguardando aprovação humana).
> Plano detalhado e vivo: [`../../.claude/state/sprint-atual.md`](../../.claude/state/sprint-atual.md).

## Objetivo

Entregar a primeira **fatia vertical** de valor — um card de KPI no dashboard que mostra o
**faturamento líquido do dia atual**, do backend ao frontend.

## Escopo incluído

1. Endpoint `GET /api/v1/kpis/faturamento-dia` → `{ data, valorLiquido, moeda }`.
2. Use case `ObterFaturamentoDoDia` no backend (Clean Arch), com port de repositório.
3. Card de KPI no dashboard (frontend) consumindo o endpoint via hook de React Query.

## Escopo explicitamente fora (limite duro)

- Qualquer outro KPI (ticket médio, YoY, projeção) — vira Sprint própria.
- Filtros (período, canal); gráfico de evolução (só o card numérico).
- Autenticação/autorização do endpoint (assume-se a já existente).

## Histórias

- **H1** — Como gestor da loja, quero ver o faturamento líquido de hoje num card no topo
  do dashboard, para acompanhar a venda do dia em tempo real.

## Critérios de aceite (resumo)

- `GET /api/v1/kpis/faturamento-dia` responde tipado; dia sem vendas → `valorLiquido: 0`.
- Card trata loading/erro; sem hardcode no front (cores/tipografia do `theme/`).
- Nenhum outro KPI ou filtro implementado (escopo futuro não vazou).

## Resultado

_(Preencher quando a Sprint for fechada no GATE 3.)_
