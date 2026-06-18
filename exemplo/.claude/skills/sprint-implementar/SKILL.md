---
name: sprint-implementar
description: Implementa SOMENTE as tasks aprovadas da Sprint corrente. Use após /sprint-aprovar. Exige a flag state/sprint-aprovada — sem ela o hook bloqueia a escrita em src/.
allowed-tools: Read, Glob, Grep, Edit, Write, Bash
---

# Implementar Sprint (Fase C)

Pré-condição: a flag `.claude/state/sprint-aprovada` existe. Se não existir, PARE
e oriente rodar /sprint-aprovar — o hook gate-bloqueio-codigo.sh barrará src/.

Execute APENAS as tasks listadas em `.claude/state/sprint-atual.md`.

1. Leia o pacote da Sprint e trabalhe task por task, na ordem de dependência.
2. Delegue por disciplina:
   - UI / React / Design System → subagente `dev-frontend`.
   - Domínio / casos de uso / API → subagente `dev-backend`.
3. Respeite as convenções de `frontend/CLAUDE.md` e `backend/CLAUDE.md`.
4. NÃO antecipe escopo. Nada de "já que estou aqui". Se algo necessário não está
   no escopo, PARE e reporte — não invente uma nova Sprint.
5. O hook pos-edicao-qualidade.sh roda typecheck a cada edição. Erro de tipo
   volta para você: corrija antes de prosseguir.

Ao concluir as tasks, avise que está pronto para o GATE 3: rode /sprint-revisar.
