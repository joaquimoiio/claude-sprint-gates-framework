#!/usr/bin/env bash
# Após cada edição em src/, valida tipos. Erro de tipo retorna ao Claude para correção.
# Resiliente: se o pacote ainda não tem package.json ou script "typecheck", apenas avisa
# e libera (exit 0) — não trava o trabalho durante o scaffold inicial.

INPUT=$(cat)

# Extrai o file_path. Usa jq (robusto a escapes) com fallback para grep/sed.
if command -v jq >/dev/null 2>&1; then
  CAMINHO=$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // empty')
else
  CAMINHO=$(printf '%s' "$INPUT" | grep -o '"file_path"[^,}]*' | sed 's/.*: *"//;s/"//')
fi

# Descobre qual pacote foi tocado
PACOTE=""
case "$CAMINHO" in
  *frontend/src/*) PACOTE="frontend" ;;
  *backend/src/*)  PACOTE="backend" ;;
  *) exit 0 ;;  # fora de src/ → nada a validar
esac

DIR="$CLAUDE_PROJECT_DIR/$PACOTE"

# Sem package.json ainda (scaffold não feito) → não trava, só avisa.
if [ ! -f "$DIR/package.json" ]; then
  echo "Aviso: $PACOTE/package.json ainda nao existe — typecheck pulado." >&2
  exit 0
fi

# package.json existe mas sem script "typecheck" → avisa e libera.
if ! grep -q '"typecheck"' "$DIR/package.json"; then
  echo "Aviso: script \"typecheck\" ausente em $PACOTE/package.json — validacao de tipos pulada." >&2
  exit 0
fi

# Roda o typecheck; erro de tipo (exit 2) volta ao Claude para correção.
(cd "$DIR" && npm run typecheck) || exit 2
exit 0
