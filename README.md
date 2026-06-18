# Framework de Sprints com Gates para Claude Code

Um framework **portátil** para desenvolver com IA (Claude Code) sob um fluxo de Sprints
com **gates determinísticos** — onde "aguarde aprovação" não é um pedido educado à IA, e
sim uma **trava física**: um hook bloqueia a escrita de código (exit code 2) enquanto a
Sprint não foi aprovada por um humano.

> A IA não consegue "correr na frente" mesmo que queira.

## Por que existe

LLMs tendem a antecipar escopo, implementar "de quebra" o que não foi pedido e pular
etapas. Este framework resolve isso com mecânica, não com boa vontade:

- **Cada fase tem um comando explícito** (`/sprint-analisar`, `/sprint-planejar`, …) — sem salto de etapa.
- **O GATE 2 é um hook**: sem a flag `state/sprint-aprovada`, `Write`/`Edit` em pastas de fonte é barrado.
- **A qualidade é determinística**: typecheck/lint rodam por hook após cada edição, não por lembrança.
- **Contexto isolado por subagente**: o `arquiteto` planeja sem implementar; os devs implementam sem redefinir escopo.

## O ciclo

```
/sprint-analisar  → entende + levanta lacunas .............. GATE 1
/sprint-planejar  → documento + histórias + tasks + critérios  GATE 2  ← código TRAVADO
/sprint-aprovar   → registra o "ok" humano, cria a flag .... destrava
/sprint-implementar → coda SOMENTE o aprovado
/sprint-revisar   → audita contra os critérios de aceite ... GATE 3
```

## Como usar num projeto novo

1. Copie **[`FRAMEWORK-SPRINT-GATES.md`](FRAMEWORK-SPRINT-GATES.md)** para a raiz do seu projeto.
2. Abra o Claude Code nele e cole o **prompt de bootstrap** (seção 2 do documento).
3. Responda às 5 perguntas (nome, codebases, stack, comando de qualidade, modelos) — o
   Claude Code monta todo o `.claude/` adaptado à sua stack.

Tudo no documento usa placeholders `<ASSIM>`; não há nada amarrado a uma linguagem ou framework.

## O que tem aqui

| Caminho | O que é |
|---------|---------|
| [`FRAMEWORK-SPRINT-GATES.md`](FRAMEWORK-SPRINT-GATES.md) | O kit portátil: conceito, **prompt de bootstrap** e todos os templates genéricos. |
| [`exemplo/`](exemplo/) | Uma instância **completa e preenchida** do framework para um projeto fictício ("Loja Analytics" — React + Node/TS). Mostra como tudo fica depois do bootstrap. |

Veja o [`exemplo/README.md`](exemplo/README.md) para um passo a passo do que cada arquivo
faz e como testar que o gate realmente bloqueia.

## Licença

MIT — use, adapte e compartilhe à vontade.
