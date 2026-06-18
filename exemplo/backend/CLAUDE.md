# Backend — Loja Analytics

Convenções **locais e obrigatórias**. Acrescentam contexto à raiz; não a reescrevem.
O que está como **PROIBIDO** reprova em review (`/sprint-revisar`).
Na dúvida sobre uma fronteira de camada, **PARE e pergunte** — não improvise.

## 1. Stack canônica (não troque sem nova Sprint)
| Camada | Ferramenta |
|--------|-----------|
| Runtime | Node.js + TypeScript **strict** |
| HTTP | Express (fina camada de entrega) |
| Arquitetura | Clean Architecture + DDD + SOLID (inegociável) |
| Validação | Schema tipado (ex.: Zod) na borda |
| Testes | Vitest/Jest (domínio testável sem subir o servidor) |

**PROIBIDO** adicionar dependência nova sem task aprovada na Sprint.

## 2. Camadas (`src/`) — a regra de dependência é sagrada
```
src/
├── domain/          # entidades, value objects, erros tipados — regras PURAS
├── application/     # use cases + ports (interfaces)
├── infrastructure/  # adapters: repositórios, db, clientes externos, config
└── interfaces/      # entrega HTTP: controllers, rotas, DTOs, validação
```
### Direção ÚNICA (de fora para dentro)
```
interfaces ─┐
            ├──► application ──► domain
infrastructure ─┘
```
- `domain` **não importa nada** de fora (sem Express, ORM, HTTP, DTO).
- `application` conhece `domain`, define **ports**; quem implementa é a `infrastructure`.
- **PROIBIDO** `import` que aponte "para fora". Inversão via ports + injeção no bootstrap.

## 3. Domínio (DDD)
1. **Domínio rico, não anêmico** — invariantes na entidade/value object, não em "service" procedural.
2. Estados inválidos **irrepresentáveis**: valide na construção (`static create()`).
3. Erros de domínio **tipados** (classes em `domain/errors`), nunca `throw new Error('string')`.
4. **PROIBIDO** framework/ORM/`req`/`res`/env dentro de `domain/`.

## 4. Casos de uso e entrega
- **Um use case = uma responsabilidade.** Recebe entrada validada, devolve resultado tipado; não conhece Express.
- Dependências externas entram como **ports injetados** no construtor. **PROIBIDO** SQL/HTTP direto no use case.
- Controllers **finos**: validar entrada → mapear DTO → chamar use case → mapear resposta → traduzir erro p/ status.
- **DTOs explícitos**; **PROIBIDO** serializar a entidade de domínio crua. API tipada e versionada (`/api/v1`).

## 5. TypeScript e segurança
- **PROIBIDO `any`**; `@ts-ignore`/`as` só com justificativa comentada. Fronteiras públicas tipadas explicitamente.
- **PROIBIDO** segredo hardcoded — config tipada lê de env, isolada em `infrastructure/config`. Domínio não lê env.

## 6. Qualidade — antes de declarar uma task pronta
- [ ] `npm run typecheck` e `npm run lint` limpos. Regra de dependência respeitada.
- [ ] Domínio sem framework/ORM/HTTP; controllers finos; DTOs explícitos; erros tipados.
- [ ] Nenhum `any` novo. Nada fora do escopo da Sprint corrente foi tocado.

> O hook `pos-edicao-qualidade.sh` roda typecheck a cada edição em `backend/src/`.
> Erro de tipo **volta para você corrigir** antes de prosseguir.
