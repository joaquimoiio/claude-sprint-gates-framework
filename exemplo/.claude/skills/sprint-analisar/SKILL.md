---
name: sprint-analisar
description: Entende a demanda e levanta lacunas antes de planejar. Para no GATE 1. Use ao receber uma nova demanda, antes de qualquer planejamento ou código.
allowed-tools: Read, Glob, Grep
---

# Analisar Demanda (Fase A → GATE 1)

Delegue ao subagente `arquiteto`. NÃO escreva código nem documento de Sprint ainda.

Objetivo desta fase: **entender** e **expor o que está ambíguo**.

1. Leia o contexto relevante do repositório (CLAUDE.md raiz, frontend/backend,
   state/sprint-atual.md se existir) e o material da demanda.
2. Resuma o entendimento da demanda em poucas linhas.
3. Liste as **lacunas e ambiguidades**: regras de negócio indefinidas, contratos
   de API não especificados, dependências, escopo dúbio.
4. Faça as **perguntas** necessárias para fechar essas lacunas.

Ao final, **PARE** no GATE 1:
"GATE 1 — entendimento. Responda as dúvidas acima. Quando estiverem fechadas,
rode /sprint-planejar."
