---
name: sprint-revisar
description: Audita a entrega da Sprint contra os critérios de aceite e a Definition of Done. Use no GATE 3, após /sprint-implementar, antes de declarar concluído.
allowed-tools: Read, Glob, Grep, Bash
---

# Revisar Sprint (Fase C → GATE 3)

Delegue ao subagente `revisor-qa`. Compare a implementação com cada item de
`.claude/state/sprint-atual.md`. NÃO escreva nem corrija código nesta fase —
apenas audite e reporte.

Verifique e reporte **item a item** (aprovado / reprovado):
1. Todos os **critérios de aceite** atendidos.
2. Nenhum **escopo futuro** vazou para o código (nada fora do escopo incluído).
3. **Design System** e convenções (frontend/backend) respeitados.
4. **typecheck** e **lint** passando nos pacotes tocados.
5. **Definition of Done** cumprida.

Ao final:
- Se houver reprovações, liste-as e devolva para /sprint-implementar corrigir.
- Se tudo aprovado, declare: "GATE 3 — pronto para validação humana. Após o ok,
  feche a Sprint removendo a flag: rm .claude/state/sprint-aprovada."
