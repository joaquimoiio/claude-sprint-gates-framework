# `.claude/` — Inteligência operacional (Loja Analytics)

Camada que a IA usa para operar como Arquiteto de Software Sênior residente. Cada arquivo
existe para a IA **decidir ou agir**, não só ler.

> Papel e fluxo: [`../CLAUDE.md`](../CLAUDE.md) · Convenções:
> [`../frontend/CLAUDE.md`](../frontend/CLAUDE.md) · [`../backend/CLAUDE.md`](../backend/CLAUDE.md)
> · Estado da Sprint: [`state/sprint-atual.md`](state/sprint-atual.md)

## Princípio que governa tudo

**Desenvolvimento por Sprint, com gates.** Só existe o escopo da Sprint atual. NÃO se
escreve código em `src/` antes de `/sprint-aprovar` — o hook `gate-bloqueio-codigo.sh`
barra de qualquer forma. Na dúvida, pare e pergunte.

## Carregamento de contexto por tarefa

| Situação | Onde olhar / o que rodar |
|----------|--------------------------|
| Nova demanda chegou | `/sprint-analisar` → para no GATE 1 |
| Planejar a Sprint | `/sprint-planejar` (subagente `arquiteto`) → escreve `state/sprint-atual.md`, para no GATE 2 |
| Liberar implementação | `/sprint-aprovar` (após "ok" humano) → cria a flag `state/sprint-aprovada` |
| Codar o aprovado | `/sprint-implementar` → só as tasks de `state/sprint-atual.md` |
| Auditar a entrega | `/sprint-revisar` (subagente `revisor-qa`) → GATE 3 |
| Vou escrever frontend | [`../frontend/CLAUDE.md`](../frontend/CLAUDE.md) |
| Vou escrever backend | [`../backend/CLAUDE.md`](../backend/CLAUDE.md) |

## O que é cada pasta

- **`skills/`** — os 5 comandos do fluxo (`/sprint-*`), cada um com frontmatter `name`/`description`.
- **`agents/`** — subagentes em contexto isolado: `arquiteto` (planeja, não coda), `dev-frontend`/`dev-backend` (implementam só o aprovado), `revisor-qa` (audita).
- **`hooks/`** — `gate-bloqueio-codigo.sh` (trava o GATE 2) e `pos-edicao-qualidade.sh` (typecheck após cada edição).
- **`state/`** — `sprint-atual.md` (escopo aprovado) e `sprint-aprovada` (flag binária; sem ela, `src/` está travado).

## Como manter

- Tarefa recorrente nova → nova skill em `skills/<nome>/SKILL.md` (com frontmatter).
- Papel novo que valha contexto isolado → novo subagente em `agents/` (frontmatter `name`/`description`/`tools`).
- **Nunca** markdown sem frontmatter em `agents/` nem em `skills/`.
