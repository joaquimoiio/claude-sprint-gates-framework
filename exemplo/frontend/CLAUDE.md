# Frontend — Loja Analytics

Convenções **locais e obrigatórias**. Acrescentam contexto à raiz; não a reescrevem.
O que está como **PROIBIDO** reprova em review (`/sprint-revisar`).
Na dúvida sobre uma regra, **PARE e pergunte** — não improvise um padrão novo.

## 1. Stack canônica (não troque sem nova Sprint)
| Camada | Ferramenta |
|--------|-----------|
| UI | React 18 + TypeScript **strict** (function components + hooks) |
| Componentes | MUI (Material UI) v5 |
| Gráficos | ECharts (via wrapper tipado) |
| Estado de servidor | TanStack Query (React Query) |
| Estado de UI | `useState` / `useReducer` / Context |
| Navegação | React Router |

**PROIBIDO** adicionar dependência nova sem task aprovada na Sprint.

## 2. Estrutura de `src/`
```
src/
├── app/            # bootstrap: providers, router, query client, theme
├── components/     # componentes burros reutilizáveis (sem regra de negócio, sem fetch)
├── features/<dominio>/   # api/ components/ hooks/ pages/ types.ts
├── hooks/          # hooks genéricos compartilhados
├── lib/            # apiClient, queryClient, helpers PUROS, formatters
├── theme/          # Design System: tokens, paleta, tipografia
└── types/          # tipos globais
```
Regra de ouro: **feature não importa de outra feature**. O compartilhado sobe para
`components/`/`hooks/`/`lib/`/`types/`.

## 3. Dados e estado (a regra que mais quebra)
1. **PROIBIDO** `fetch`/`axios` dentro de componente/página. Rede só em `features/<x>/api/` como hook de React Query.
2. Componente **consome** dados (`const { data } = useX()`), nunca os busca.
3. **PROIBIDO duplicar** dados do servidor em `useState` — React Query é a fonte de verdade.
4. `isLoading`/`isError` são estados de primeira classe em todo consumo de dados.

## 4. TypeScript (strict, sem exceções)
- **PROIBIDO `any`** (use `unknown` + narrowing). `as`/`@ts-ignore` só com justificativa comentada.
- Contratos de API tipados junto da feature (`types.ts`). Props tipadas como interface (sem `React.FC`).

## 5. Design System
- Use **somente** tokens de `theme/`. **PROIBIDO** valor hardcoded (`#FFF`, `margin: '12px'`, `fontSize: 14`).
- Estética: densidade baixa, hierarquia clara, sem ornamento gratuito. Consistência > criatividade.
- ECharts sempre via wrapper tipado; `option` memoizada (`useMemo`); cores vindas do `theme/`.

## 6. Qualidade — antes de declarar uma task pronta
- [ ] `npm run typecheck` e `npm run lint` limpos.
- [ ] Nenhum `any`/`@ts-ignore`/valor hardcoded novo. Nenhum `fetch`/`axios` em componente.
- [ ] Loading e erro tratados. Nada fora do escopo da Sprint corrente foi tocado.

> O hook `pos-edicao-qualidade.sh` roda typecheck a cada edição em `frontend/src/`.
> Erro de tipo **volta para você corrigir** antes de prosseguir.
