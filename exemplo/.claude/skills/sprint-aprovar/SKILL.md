---
name: sprint-aprovar
description: Registra a aprovação humana do planejamento e libera a implementação. Só rode após o usuário aprovar explicitamente o pacote da Sprint.
allowed-tools: Bash(touch *), Read
---

# Aprovar Sprint (libera GATE 2)

Confirme que o usuário aprovou explicitamente o conteúdo de `.claude/state/sprint-atual.md`.
Em caso afirmativo, crie a flag:

    touch .claude/state/sprint-aprovada

A partir daqui, /sprint-implementar pode escrever código em src/.
Ao fechar a Sprint, remova a flag (rm .claude/state/sprint-aprovada) para reativar o gate.
