#!/usr/bin/env bash
# Barra escrita/edição de código-fonte enquanto a Sprint não foi aprovada.
# Recebe o JSON do tool via stdin. Exit 2 = bloqueio que o Claude respeita.

INPUT=$(cat)

# Extrai o file_path. Usa jq (robusto a escapes) com fallback para grep/sed.
if command -v jq >/dev/null 2>&1; then
  CAMINHO=$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // empty')
else
  CAMINHO=$(printf '%s' "$INPUT" | grep -o '"file_path"[^,}]*' | sed 's/.*: *"//;s/"//')
fi

# Só nos importam arquivos de código (frontend/src ou backend/src)
case "$CAMINHO" in
  *frontend/src/*|*backend/src/*) ;;
  *) exit 0 ;;  # docs, state, config → liberado
esac

if [ ! -f "$CLAUDE_PROJECT_DIR/.claude/state/sprint-aprovada" ]; then
  echo "GATE 2 ativo: a Sprint ainda nao foi aprovada. Rode /sprint-aprovar apos o ok humano antes de escrever codigo em src/." >&2
  exit 2
fi
exit 0
