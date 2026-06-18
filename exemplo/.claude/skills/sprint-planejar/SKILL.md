---
name: sprint-planejar
description: Cria o pacote de planejamento da Sprint (documento, histórias, tasks, critérios de aceite) e PARA no GATE 2. Use após o entendimento estar validado.
allowed-tools: Read, Glob, Grep, Write
---

# Planejar Sprint (Fase B → GATE 2)

Delegue ao subagente `arquiteto`. Produza, em `.claude/state/sprint-atual.md`:

1. **Documento da Sprint** — objetivo, escopo incluído, escopo EXPLICITAMENTE fora, premissas, dependências.
2. **Histórias de usuário** — "Como <persona>, quero <ação>, para <valor>."
3. **Tasks técnicas** por história (frontend / backend / contratos de API), pequenas e rastreáveis.
4. **Critérios de aceite** mensuráveis + Definition of Done.

Ao final, apresente o pacote e **PARE**. NÃO escreva código.
Avise: "GATE 2 — aguardando aprovação. Rode /sprint-aprovar quando validar."
