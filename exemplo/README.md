# Exemplo instanciado — "Loja Analytics"

Esta pasta mostra **como o framework fica depois do bootstrap**, preenchido para um projeto
fictício chamado **Loja Analytics** (dashboard de vendas: React + TypeScript no frontend,
Node + Express + TypeScript com Clean Architecture no backend).

> É um exemplo de referência — não um app que roda. Os `src/` propositalmente não existem:
> o ponto é demonstrar a **estrutura de governança**, não código de aplicação.

## Mapa do que está aqui

```
exemplo/
├── CLAUDE.md                     # Constituição: princípios + fluxo + gates
├── .gitignore                    # ignora a flag de aprovação e overrides locais
├── frontend/CLAUDE.md            # convenções React + TS + MUI + React Query
├── backend/CLAUDE.md             # convenções Node + Express + TS + Clean Arch/DDD
├── docs/
│   └── sprints/                  # roteiro durável das Sprints (1 arquivo por Sprint)
│       ├── README.md             # quadro: feito / em andamento / a fazer
│       ├── sprint-1-faturamento-dia.md   # 🔵 em andamento (parada no GATE 2)
│       └── sprint-2-ticket-medio.md      # ⚪ a fazer (proposta)
└── .claude/
    ├── README.md                 # mapa do .claude/ + tabela de carregamento de contexto
    ├── settings.json             # registra os dois hooks (PreToolUse / PostToolUse)
    ├── hooks/
    │   ├── gate-bloqueio-codigo.sh   # ← a trava do GATE 2
    │   └── pos-edicao-qualidade.sh   # ← typecheck após cada edição
    ├── skills/                   # os 5 comandos do fluxo
    │   ├── sprint-analisar/SKILL.md
    │   ├── sprint-planejar/SKILL.md
    │   ├── sprint-aprovar/SKILL.md
    │   ├── sprint-implementar/SKILL.md
    │   └── sprint-revisar/SKILL.md
    ├── agents/                   # 4 subagentes (contexto isolado)
    │   ├── arquiteto.md · dev-frontend.md · dev-backend.md · revisor-qa.md
    └── state/
        └── sprint-atual.md       # plano vivo da Sprint corrente, PARADA no GATE 2
```

> Note que **não há** `state/sprint-aprovada`: a Sprint de exemplo está aguardando o "ok"
> humano, então o código estaria travado neste momento.

> **`state/sprint-atual.md` × `docs/sprints/`:** o primeiro é o plano **vivo** da Sprint
> corrente (uma por vez); o segundo é o **registro durável** de todas as Sprints — um
> arquivo por Sprint mais o quadro de status. `/sprint-planejar` cria o registro e o marca
> 🔵; `/sprint-revisar`, ao fechar, marca ✅.

## Como ver o gate funcionando de verdade

Dentro de `exemplo/`, com o Claude Code:

1. Peça para criar um arquivo em `frontend/src/foo.ts`.
   → O hook `gate-bloqueio-codigo.sh` **bloqueia** (não existe `state/sprint-aprovada`).
2. Rode `/sprint-aprovar` (ou crie a flag manualmente: `touch .claude/state/sprint-aprovada`).
3. Tente de novo → agora **passa**, e o hook de qualidade roda o typecheck.
4. Feche a Sprint: `rm .claude/state/sprint-aprovada` → o gate volta a travar.

## Como este exemplo nasceu

Foi exatamente o que o **prompt de bootstrap** (seção 2 do
[`../FRAMEWORK-SPRINT-GATES.md`](../FRAMEWORK-SPRINT-GATES.md)) gera quando você responde:

- **Projeto:** Loja Analytics · **Papel:** Arquiteto de Software Sênior
- **Codebases:** `frontend/src` (React+TS) e `backend/src` (Node+Express+TS, Clean Arch+DDD)
- **Qualidade:** `npm run typecheck && npm run lint`
- **Modelos:** arquiteto=opus, devs e qa=sonnet
