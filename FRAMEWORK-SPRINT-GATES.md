# Framework de Desenvolvimento com IA — Sprints com Gates (`.claude`)
### Kit portátil · use em qualquer projeto

Este documento é **reutilizável**: copie-o para a raiz de um projeto novo e use o prompt da
seção 2 para o Claude Code montar toda a estrutura `.claude/`. A ideia central:

> **Os GATES não são pedidos educados — são travas determinísticas.**
> Onde o fluxo manda "aguarde aprovação", um *hook* bloqueia a escrita de código de verdade
> (exit code 2). A IA não consegue "correr na frente" mesmo que queira.

> Tudo aqui usa **placeholders** `<ASSIM>`. Não há nada amarrado a uma stack específica —
> você preenche os valores do seu projeto na seção 1.

---

## 1. PREENCHA ANTES (os únicos valores específicos do projeto)

Decida estes valores; o prompt da seção 2 vai pedi-los e o resto se monta sozinho.

| Placeholder | O que é | Exemplo |
|-------------|---------|---------|
| `<NOME_PROJETO>` | Nome do produto/repo | `Analytics Omnichannel` |
| `<PAPEL_IA>` | Papel que a IA assume | `Arquiteto de Software Sênior` |
| `<CODEBASES>` | Lista de codebases e a pasta de fonte de cada um | `frontend/src`, `backend/src` (ou só `src/` num repo único) |
| `<STACK_POR_CODEBASE>` | Stack canônica de cada codebase | `React+TS+MUI` / `Node+Express+TS, Clean Arch+DDD` |
| `<CMD_QUALIDADE>` | Comando que valida cada codebase | `npm run typecheck && npm run lint` |
| `<MODELO_ARQUITETO>` / `<MODELO_DEV>` / `<MODELO_QA>` | Modelo por subagente (opcional) | `opus` / `sonnet` / `sonnet` |

> **Repo único?** `<CODEBASES>` vira só `src/`, e você usa um único `CLAUDE.md` de
> convenções na raiz (não precisa de `frontend/CLAUDE.md` etc.).
> **Monorepo com 3+ apps?** Liste todos; o hook abaixo aceita N pastas de fonte.

---

## 2. PROMPT DE BOOTSTRAP (copie e cole no Claude Code)

> Cole o bloco abaixo numa sessão do Claude Code na raiz do projeto novo. Ele pergunta os
> valores da seção 1, depois cria a árvore inteira. Não escreve código de aplicação —
> só o andaime do framework.

```
Quero instalar neste repositório o "Framework de Sprints com Gates" para Claude Code.
Antes de criar qualquer arquivo, me pergunte (uma vez, de forma objetiva):

1. Nome do projeto e o papel que você deve assumir (ex.: Arquiteto de Software Sênior).
2. Quais codebases existem e a pasta de fonte de cada um (ex.: frontend/src, backend/src,
   ou só src/ se for repo único).
3. A stack canônica de cada codebase (linguagem, framework, libs, arquitetura).
4. O comando de qualidade de cada codebase (typecheck/lint/testes).
5. Modelos por subagente (opcional; default: arquiteto=opus, devs e qa=sonnet).

Com as respostas, crie EXATAMENTE esta estrutura, usando os valores que eu der e seguindo
os templates da seção 3 do FRAMEWORK-SPRINT-GATES.md (que está na raiz):

- CLAUDE.md (raiz) — constituição: princípios + fluxo + gates + comandos de qualidade.
- Um CLAUDE.md de convenções por codebase (pule se for repo único — coloque tudo na raiz).
- .claude/settings.json — permissões + os dois hooks.
- .claude/hooks/gate-bloqueio-codigo.sh e pos-edicao-qualidade.sh (chmod +x), com as
  pastas de fonte e os comandos de qualidade que eu informei.
- .claude/skills/{sprint-analisar,sprint-planejar,sprint-aprovar,sprint-implementar,
  sprint-revisar}/SKILL.md — cada uma com frontmatter name/description/allowed-tools.
- .claude/agents/{arquiteto,dev-frontend,dev-backend,revisor-qa}.md — com frontmatter
  name/description/tools/model (adapte os devs aos codebases reais).
- .claude/state/sprint-atual.md (placeholder inicial) e .gitignore ignorando
  .claude/state/sprint-aprovada e .claude/settings.local.json.
- .claude/README.md — mapa do .claude/ com a tabela "carregamento de contexto por tarefa".
- docs/sprints/README.md — o quadro de Sprints (feito / em andamento / a fazer), com a
  legenda de status e a tabela inicial vazia (ou com a Sprint 1 se já houver uma).

Regras ao gerar:
- Os hooks devem casar SÓ as pastas de fonte que eu listei; docs/state/config ficam livres.
- Não crie código de aplicação nem dependências — só o andaime.
- Ao terminar, me mostre a árvore criada e como rodar o primeiro /sprint-analisar.
```

---

## 3. TEMPLATES DOS ARQUIVOS (genéricos)

### 3.1 Árvore de diretórios

```
<NOME_PROJETO>/
├── CLAUDE.md                         # Constituição (princípios + fluxo + gates)
├── FRAMEWORK-SPRINT-GATES.md         # Este documento (kit portátil)
│
├── <codebaseA>/CLAUDE.md             # Convenções da codebase A  (omita se repo único)
├── <codebaseB>/CLAUDE.md             # Convenções da codebase B
│
├── docs/
│   └── sprints/                      # Roteiro durável das Sprints (1 arquivo por Sprint)
│       ├── README.md                 # Quadro: feito / em andamento / a fazer
│       └── sprint-<N>-<slug>.md       # Registro durável de cada Sprint
│
└── .claude/
    ├── settings.json                 # Permissões + hooks (gates) — versionado
    ├── settings.local.json           # Overrides pessoais — fora do git
    ├── README.md                     # Mapa do .claude/
    │
    ├── skills/                       # Os passos do fluxo, invocáveis por /comando
    │   ├── sprint-analisar/SKILL.md      # Fase A  → /sprint-analisar
    │   ├── sprint-planejar/SKILL.md      # Fase B  → /sprint-planejar
    │   ├── sprint-aprovar/SKILL.md       # GATE 2  → /sprint-aprovar
    │   ├── sprint-implementar/SKILL.md   # Fase C  → /sprint-implementar
    │   └── sprint-revisar/SKILL.md       # GATE 3  → /sprint-revisar
    │
    ├── agents/                       # Subagentes especializados (contexto isolado)
    │   ├── arquiteto.md
    │   ├── dev-frontend.md  · dev-backend.md   # adapte às codebases reais
    │   └── revisor-qa.md
    │
    ├── hooks/
    │   ├── gate-bloqueio-codigo.sh       # PreToolUse: barra código sem Sprint aprovada
    │   └── pos-edicao-qualidade.sh       # PostToolUse: qualidade após cada edição
    │
    └── state/
        ├── sprint-atual.md               # Plano VIVO da Sprint corrente (uma por vez)
        └── sprint-aprovada               # FLAG: existe apenas após o GATE 2
```

> **`state/sprint-atual.md` × `docs/sprints/`:** o primeiro é o plano **vivo** da Sprint
> corrente; o segundo é o **registro durável** de todas as Sprints (um arquivo por Sprint +
> o quadro `README.md`). `/sprint-planejar` cria/atualiza o registro e o marca 🔵;
> `/sprint-revisar`, ao fechar a Sprint, o marca ✅. É assim que "feito / a fazer" fica visível.

### 3.2 `CLAUDE.md` (raiz)

```markdown
# <NOME_PROJETO>

Você é <PAPEL_IA> atuando neste repositório.
Resumo operacional que vale em TODA sessão:

## Princípios inegociáveis
1. Desenvolvimento por Sprint. Só existe o escopo da Sprint atual.
2. NUNCA implemente funcionalidade futura nem antecipe escopo.
3. Respeite arquitetura, convenções e regras de negócio definidos.
4. Na dúvida, pergunte. Pare nos gates.

## Fluxo (use os comandos)
- /sprint-analisar    → entender + levantar lacunas (GATE 1)
- /sprint-planejar    → documento + histórias + tasks + critérios (GATE 2)
- /sprint-aprovar     → registra o "ok" humano e libera a implementação
- /sprint-implementar → codar SOMENTE o aprovado
- /sprint-revisar     → auditar contra os critérios de aceite (GATE 3)

## Regra dura
NÃO escreva/edite código nas pastas de fonte antes de /sprint-aprovar.
O hook gate-bloqueio-codigo.sh vai barrar de qualquer forma.

## Build / Qualidade
<por codebase: cd <codebase> && <CMD_QUALIDADE>>
```

### 3.3 `.claude/settings.json`

```json
{
  "permissions": {
    "deny": ["Read(./.env)", "Read(./**/secrets/**)"]
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          { "type": "command", "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/gate-bloqueio-codigo.sh" }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          { "type": "command", "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/pos-edicao-qualidade.sh", "timeout": 120 }
        ]
      }
    ]
  }
}
```

### 3.4 `.claude/hooks/gate-bloqueio-codigo.sh` — a trava do GATE 2

```bash
#!/usr/bin/env bash
# Barra escrita/edição de código-fonte enquanto a Sprint não foi aprovada.
# Recebe o JSON do tool via stdin. Exit 2 = bloqueio que o Claude respeita.

INPUT=$(cat)
# jq se disponível (robusto); senão, fallback com sed.
if command -v jq >/dev/null 2>&1; then
  CAMINHO=$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // empty')
else
  CAMINHO=$(printf '%s' "$INPUT" | grep -o '"file_path"[^,}]*' | sed 's/.*: *"//;s/"//')
fi

# === EDITE: as pastas de fonte do seu projeto ===
case "$CAMINHO" in
  */src/*) ;;                       # repo único
  # *frontend/src/*|*backend/src/*) ;;   # multi-codebase: descomente/ajuste
  *) exit 0 ;;                       # docs, state, config → liberado
esac

if [ ! -f "$CLAUDE_PROJECT_DIR/.claude/state/sprint-aprovada" ]; then
  echo "GATE 2 ativo: a Sprint ainda nao foi aprovada. Rode /sprint-aprovar apos o ok humano antes de escrever codigo nas pastas de fonte." >&2
  exit 2
fi
exit 0
```

### 3.5 `.claude/hooks/pos-edicao-qualidade.sh` — gate de qualidade

```bash
#!/usr/bin/env bash
# Após cada edição em pasta de fonte, valida qualidade. Falha retorna ao Claude.
INPUT=$(cat)
if command -v jq >/dev/null 2>&1; then
  CAMINHO=$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // empty')
else
  CAMINHO=$(printf '%s' "$INPUT" | grep -o '"file_path"[^,}]*' | sed 's/.*: *"//;s/"//')
fi

# === EDITE: mapeie pasta de fonte → comando de qualidade ===
case "$CAMINHO" in
  *frontend/src/*) (cd "$CLAUDE_PROJECT_DIR/frontend" && <CMD_QUALIDADE>) || exit 2 ;;
  *backend/src/*)  (cd "$CLAUDE_PROJECT_DIR/backend"  && <CMD_QUALIDADE>) || exit 2 ;;
  */src/*)         (cd "$CLAUDE_PROJECT_DIR"          && <CMD_QUALIDADE>) || exit 2 ;;  # repo único
esac
exit 0
```

> Lembre de `chmod +x .claude/hooks/*.sh`.

### 3.6 `.claude/skills/sprint-analisar/SKILL.md`

```markdown
---
name: sprint-analisar
description: Entende a demanda e levanta lacunas antes de planejar. Para no GATE 1. Use ao receber uma nova demanda, antes de qualquer planejamento ou código.
allowed-tools: Read, Glob, Grep
---

# Analisar Sprint (Fase A → GATE 1)

Delegue ao subagente `arquiteto`. Entenda a demanda e produza:
1. **Entendimento** — o que se pede, em que contexto, qual valor.
2. **Lacunas / perguntas** — tudo que está ambíguo ou indefinido (regra de negócio,
   contrato de dado, escopo). Marque `[A DECIDIR]` em cada uma.
3. **Riscos e dependências** conhecidos.

PARE no GATE 1. NÃO planeje nem escreva código.
Avise: "GATE 1 — preciso destas decisões antes de planejar." e liste as lacunas.
```

### 3.7 `.claude/skills/sprint-planejar/SKILL.md`

```markdown
---
name: sprint-planejar
description: Cria o pacote de planejamento da Sprint (documento, histórias, tasks, critérios de aceite), registra a Sprint em docs/sprints/ e PARA no GATE 2. Use após o entendimento estar validado.
allowed-tools: Read, Glob, Grep, Write
---

# Planejar Sprint (Fase B → GATE 2)

Delegue ao subagente `arquiteto`. Produza, em `.claude/state/sprint-atual.md`:

1. **Documento da Sprint** — objetivo, escopo incluído, escopo EXPLICITAMENTE fora, premissas, dependências.
2. **Histórias de usuário** — "Como <persona>, quero <ação>, para <valor>."
3. **Tasks técnicas** por história, pequenas e rastreáveis.
4. **Critérios de aceite** mensuráveis + Definition of Done.

Depois, registre a Sprint no **roteiro durável** em `docs/sprints/`:

5. Crie/atualize `docs/sprints/sprint-<N>-<slug>.md` com o resumo durável (objetivo, escopo
   incluído/fora, histórias, critérios). O plano completo e vivo fica em `state/sprint-atual.md`;
   este arquivo é o registro permanente.
6. Atualize o quadro `docs/sprints/README.md`: status da Sprint para **🔵 Em andamento**.

Ao final, apresente o pacote e **PARE**. NÃO escreva código.
Avise: "GATE 2 — aguardando aprovação. Rode /sprint-aprovar quando validar."
```

### 3.8 `.claude/skills/sprint-aprovar/SKILL.md`

```markdown
---
name: sprint-aprovar
description: Registra a aprovação humana do planejamento e libera a implementação. Só rode após o usuário aprovar explicitamente o pacote da Sprint.
allowed-tools: Bash(touch *), Read
---

# Aprovar Sprint (libera GATE 2)

Confirme que o usuário aprovou explicitamente `.claude/state/sprint-atual.md`.
Em caso afirmativo, crie a flag:

    touch .claude/state/sprint-aprovada

A partir daqui, /sprint-implementar pode escrever código nas pastas de fonte.
Ao fechar a Sprint, remova a flag (rm .claude/state/sprint-aprovada) para reativar o gate.
```

### 3.9 `.claude/skills/sprint-implementar/SKILL.md`

```markdown
---
name: sprint-implementar
description: Implementa SOMENTE as tasks aprovadas da Sprint corrente. Use após /sprint-aprovar. Exige a flag state/sprint-aprovada — sem ela o hook bloqueia.
allowed-tools: Read, Glob, Grep, Edit, Write, Bash
---

# Implementar Sprint (Fase C)

Pré-requisito: existe `.claude/state/sprint-aprovada` (senão o hook barra).
Implemente APENAS as tasks listadas em `.claude/state/sprint-atual.md`. Para cada uma:
delegue ao subagente certo (`dev-frontend`/`dev-backend`), respeite as convenções da
codebase, e NÃO toque em nada fora do escopo. O hook de qualidade roda a cada edição.
```

### 3.10 `.claude/skills/sprint-revisar/SKILL.md`

```markdown
---
name: sprint-revisar
description: Audita a entrega da Sprint contra os critérios de aceite e a Definition of Done. Use no GATE 3, após /sprint-implementar, antes de declarar concluído.
allowed-tools: Read, Glob, Grep, Bash, Edit
---

# Revisar Sprint (GATE 3)

Delegue ao subagente `revisor-qa`. Compare a entrega com cada critério de aceite de
`.claude/state/sprint-atual.md`: (a) todos atendidos, (b) nenhum escopo futuro vazou,
(c) convenções respeitadas, (d) qualidade passando. Reporte aprovado/reprovado item a
item e PARE no GATE 3 para validação humana. NÃO corrija **código** aqui — só audite.

Ao **fechar a Sprint** (após o ok humano), atualize o roteiro durável:
- `docs/sprints/sprint-<N>-<slug>.md`: status para **✅ Concluída** (data/commit) + resultado.
- `docs/sprints/README.md`: status da Sprint no quadro para **✅ Concluída**.
```

### 3.14 `docs/sprints/README.md` — o quadro (template)

```markdown
# Sprints — quadro e histórico

> Roteiro durável das Sprints. Uma Sprint por arquivo `sprint-<N>-<slug>.md`; este
> README é o quadro. A Sprint corrente tem o plano vivo em `.claude/state/sprint-atual.md`.

| Símbolo | Status | Significado |
|---------|--------|-------------|
| ✅ | Concluída | GATE 3 aprovado + validação humana. |
| 🔵 | Em andamento | Planejada/aprovada; em implementação ou revisão. |
| ⚪ | A fazer | Proposta no roteiro; ainda não analisada/planejada. |

| Sprint | Status | Foco | Arquivo |
|--------|--------|------|---------|
| <N> — <título> | 🔵 Em andamento | <foco curto> | [`sprint-<N>-<slug>.md`](sprint-<N>-<slug>.md) |
```

### 3.15 `docs/sprints/sprint-<N>-<slug>.md` — registro de uma Sprint (template)

```markdown
# Sprint <N> — <título>

> **Status: 🔵 Em andamento** (ou ✅ Concluída / ⚪ A fazer).
> Plano vivo: `../../.claude/state/sprint-atual.md`.

## Objetivo
<o valor da fatia vertical>

## Escopo incluído
1. ...

## Escopo explicitamente fora (limite duro)
- ...

## Histórias
- **H1** — Como <persona>, quero <ação>, para <valor>.

## Critérios de aceite (resumo)
- ...

## Resultado
_(Preencher quando a Sprint for fechada no GATE 3.)_
```

> Sprints **a fazer** entram como `⚪` com um esboço (valor + indicadores/endpoints
> previstos); só ganham escopo fechado quando passam pelos GATEs 1 e 2.

### 3.11 `.claude/agents/arquiteto.md`

```markdown
---
name: arquiteto
description: Analisa requisitos e planeja Sprints. Use nas fases de entendimento e planejamento. Não escreve código de produção.
tools: Read, Glob, Grep, Write
model: <MODELO_ARQUITETO>
---

Você é <PAPEL_IA>. Seu trabalho é entender a demanda, expor lacunas e produzir o pacote
da Sprint (documento, histórias, tasks, critérios). Você NUNCA implementa funcionalidade
fora do escopo aberto e NUNCA escreve código de produção — isso é dos devs. Respeite as
convenções e as regras de negócio do produto.
```

### 3.12 `.claude/agents/dev-frontend.md` / `dev-backend.md`

```markdown
---
name: dev-<disciplina>
description: Implementa <UI dentro do Design System | domínio/API seguindo a arquitetura>. Use na Fase C para tasks já aprovadas. Não redefine escopo nem planeja Sprint.
tools: Read, Glob, Grep, Edit, Write, Bash
model: <MODELO_DEV>
---

Você implementa SOMENTE tasks aprovadas da Sprint, seguindo as convenções de
<codebase>/CLAUDE.md. Não redefine escopo, não antecipa funcionalidade futura, não toca
em arquivos fora das tasks. Qualidade (typecheck/lint) deve passar antes de declarar pronto.
```

### 3.13 `.claude/agents/revisor-qa.md`

```markdown
---
name: revisor-qa
description: Audita a entrega da Sprint contra os critérios de aceite e a Definition of Done. Use no GATE 3, antes de declarar concluído.
tools: Read, Glob, Grep, Bash
model: <MODELO_QA>
---

Você é revisor de QA. Compare a implementação com cada critério de aceite em
.claude/state/sprint-atual.md. Verifique: (a) todos os critérios atendidos, (b) nenhum
escopo futuro vazou, (c) convenções respeitadas, (d) qualidade passando. Reporte
aprovado/reprovado item a item.
```

---

## 4. CICLO NA PRÁTICA

```
Nova demanda
   │
   ▼
/sprint-analisar ──► GATE 1: dúvidas respondidas? ──(não)──► aguarda
   │ (sim)
   ▼
/sprint-planejar ──► gera state/sprint-atual.md + registra em docs/sprints/ (🔵)
   │                   ──► GATE 2: humano aprova?
   │
   │  ⨉ código nas pastas de fonte está BLOQUEADO pelo hook
   ▼
/sprint-aprovar  ──► cria flag sprint-aprovada ──► destrava as pastas de fonte
   │
   ▼
/sprint-implementar ──► devs implementam só o aprovado
   │                     (hook roda qualidade a cada edição)
   ▼
/sprint-revisar  ──► revisor-qa audita ──► GATE 3: humano valida
   │                   ──► ao fechar, marca a Sprint ✅ em docs/sprints/
   ▼
Fechar Sprint (rm flag) ──► volta ao topo
```

---

## 5. POR QUE ESSA ARQUITETURA FUNCIONA

- **"Nunca implemente funcionalidade futura"** deixa de depender de boa vontade da IA: sem
  a flag de aprovação, o hook barra a escrita de código (exit 2).
- **Cada fase tem ponto de entrada explícito** (`/sprint-*`) — sem salto de etapa.
- **Contexto isolado por subagente** mantém o `arquiteto` longe de implementação e os devs
  longe de redefinir escopo.
- **Qualidade é determinística**: typecheck/lint por hook, não por lembrança.
- **Convenções moram onde o código mora** (`<codebase>/CLAUDE.md`), evitando um arquivo gigante.

---

## 6. CHECKLIST DE INSTALAÇÃO

- [ ] `FRAMEWORK-SPRINT-GATES.md` copiado para a raiz do projeto novo.
- [ ] Valores da seção 1 decididos.
- [ ] Prompt da seção 2 rodado (ou árvore criada manualmente a partir da seção 3).
- [ ] Hooks com as **pastas de fonte certas** e `chmod +x`.
- [ ] `.gitignore` ignora `.claude/state/sprint-aprovada` e `.claude/settings.local.json`.
- [ ] Teste do gate: tente editar um arquivo de fonte SEM a flag → deve ser **bloqueado**.
- [ ] `docs/sprints/README.md` (quadro) criado; `/sprint-planejar` registra cada Sprint lá.
- [ ] `/sprint-analisar` roda e para no GATE 1.

> Adapte os nomes dos subagentes dev às codebases reais (ex.: `dev-mobile`, `dev-data`).
> As skills são o ponto canônico do fluxo; `.claude/commands/*.md` também funciona se você
> preferir o formato antigo de comandos.
```
