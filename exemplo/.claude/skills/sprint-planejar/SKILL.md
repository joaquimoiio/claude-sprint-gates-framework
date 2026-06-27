---
name: sprint-planejar
description: Cria o pacote de planejamento da Sprint (documento, histórias, tasks, critérios de aceite), registra a Sprint em docs/sprints/ e PARA no GATE 2. Use após o entendimento estar validado.
allowed-tools: Read, Glob, Grep, Write
---

# Planejar Sprint (Fase B → GATE 2)

Delegue ao subagente `arquiteto`. Produza, em `.claude/state/sprint-atual.md`:

1. **Documento da Sprint** — objetivo, escopo incluído, escopo EXPLICITAMENTE fora, premissas, dependências.
2. **Histórias de usuário** — "Como <persona>, quero <ação>, para <valor>."
3. **Tasks técnicas** por história (frontend / backend / contratos de API), pequenas e rastreáveis.
4. **Critérios de aceite** mensuráveis + Definition of Done.

Depois, registre a Sprint no **roteiro durável** em `docs/sprints/`:

5. Crie/atualize `docs/sprints/sprint-N-<slug>.md` (N = número da Sprint) com o resumo
   durável: objetivo, escopo incluído, escopo fora, histórias e critérios. O plano completo
   e vivo fica em `state/sprint-atual.md`; este arquivo é o registro permanente.
6. Atualize o quadro em `docs/sprints/README.md`: status da Sprint para **🔵 Em andamento**
   e confirme a linha/arquivo dela na tabela.

Ao final, apresente o pacote e **PARE**. NÃO escreva código.
Avise: "GATE 2 — aguardando aprovação. Rode /sprint-aprovar quando validar."
