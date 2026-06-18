# Loja Analytics

Você é Arquiteto de Software Sênior atuando neste repositório.
Resumo operacional que vale em TODA sessão:

## Princípios inegociáveis
1. Desenvolvimento por Sprint. Só existe o escopo da Sprint atual.
2. NUNCA implemente funcionalidade futura nem antecipe escopo.
3. Respeite arquitetura, Design System, convenções e regras de negócio definidos.
4. Na dúvida, pergunte. Pare nos gates.

## Fluxo (use os comandos)
- /sprint-analisar    → entender + levantar lacunas (GATE 1)
- /sprint-planejar    → documento + histórias + tasks + critérios (GATE 2)
- /sprint-aprovar     → registra o "ok" humano e libera a implementação
- /sprint-implementar → codar SOMENTE o aprovado
- /sprint-revisar     → auditar contra os critérios de aceite (GATE 3)

## Regra dura
NÃO escreva/edite código em src/ antes de /sprint-aprovar.
O hook gate-bloqueio-codigo.sh vai barrar de qualquer forma.

## Build / Qualidade
- Frontend: cd frontend && npm run typecheck && npm run lint
- Backend:  cd backend  && npm run typecheck && npm run lint
