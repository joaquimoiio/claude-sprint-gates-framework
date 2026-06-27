# Sprints — quadro e histórico (Loja Analytics)

> **Fonte de verdade do roteiro de Sprints.** Cada Sprint é uma **fatia vertical**
> (dado → API → tela) com seu próprio arquivo aqui. Este `README.md` é o **quadro**:
> o que está feito, o que está em andamento e o que falta.

## Como funciona

- **Uma Sprint por arquivo.** Escopo, histórias e critérios de cada Sprint vivem em
  `sprint-N-<slug>.md`.
- **A Sprint corrente** tem seu plano detalhado e vivo em
  [`../../.claude/state/sprint-atual.md`](../../.claude/state/sprint-atual.md) (preenchido
  por `/sprint-planejar`). O arquivo aqui é o **registro durável**: criado/atualizado quando
  a Sprint é **planejada** (GATE 2) e recebe o snapshot final quando é **fechada** (GATE 3).
- **Sempre que algo for preparado** (nova Sprint planejada, escopo ajustado, Sprint
  concluída), o arquivo da Sprint **e este quadro** são atualizados. As skills
  `/sprint-planejar` e `/sprint-revisar` cuidam disso.

## Legenda de status

| Símbolo | Status | Significado |
|---------|--------|-------------|
| ✅ | Concluída | GATE 3 aprovado + validação humana. |
| 🔵 | Em andamento | Planejada/aprovada; em implementação ou revisão. |
| ⚪ | A fazer | Proposta no roteiro; ainda não analisada/planejada. |

## Quadro

| Sprint | Status | Foco | Arquivo |
|--------|--------|------|---------|
| 1 — KPI de Faturamento do Dia | 🔵 Em andamento | Primeira fatia vertical: card de faturamento líquido de hoje. | [`sprint-1-faturamento-dia.md`](sprint-1-faturamento-dia.md) |
| 2 — Ticket médio do dia | ⚪ A fazer | Segundo KPI no dashboard. | [`sprint-2-ticket-medio.md`](sprint-2-ticket-medio.md) |

> Esta é uma instância de **exemplo**: a Sprint 1 está parada no GATE 2 (aguardando o "ok"
> humano), por isso aparece como 🔵 Em andamento. Quando uma nova ideia vira Sprint, ela
> ganha um `sprint-N-<slug>.md` e uma linha aqui.
