#!/usr/bin/env bash

set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

echo ""
echo "=========================================="
echo "   OpenAI Codex + Telegram"
echo "=========================================="
echo ""

# ------------------------------------------------------------
# Kontrola závislostí
# ------------------------------------------------------------

echo "→ Kontroluji prostředí..."

MISSING=0

for cmd in curl git python3; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ Chybí: $cmd"
        MISSING=1
    fi
done

if [ "$MISSING" -eq 1 ]; then
    echo ""
    echo "Na tomto serveru chybí potřebné systémové nástroje."
    echo "Je potřeba je jednorázově nainstalovat administrátorem."
    exit 1
fi

# Python 3.10+
if ! python3 - <<'PY'
import sys
sys.exit(0 if sys.version_info >= (3, 10) else 1)
PY
then
    echo "❌ Je potřeba Python 3.10 nebo novější."
    python3 --version
    exit 1
fi

echo "✅ curl"
echo "✅ git"
echo "✅ $(python3 --version)"


# ------------------------------------------------------------
# 1. Codex
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "   1/3 OpenAI Codex"
echo "=========================================="
echo ""

if command -v codex >/dev/null 2>&1; then

    echo "✅ Codex už je nainstalovaný:"
    codex --version

else

    echo "→ Instaluji Codex..."

    curl -fsSL https://chatgpt.com/codex/install.sh \
        | CODEX_NON_INTERACTIVE=1 sh

    export PATH="$HOME/.local/bin:$PATH"
fi

if ! command -v codex >/dev/null 2>&1; then
    echo "❌ Codex se nepodařilo nainstalovat."
    exit 1
fi

echo "✅ Codex:"
codex --version


# ------------------------------------------------------------
# 2. Login
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "   2/3 Přihlášení do ChatGPT"
echo "=========================================="
echo ""

if codex login status >/dev/null 2>&1; then

    echo "✅ Codex je už přihlášený."

else

    echo "Teď propojíš Codex se svým ChatGPT účtem."
    echo ""

    if [ -e /dev/tty ]; then
        codex login --device-auth </dev/tty
    else
        echo "Spusť ručně:"
        echo ""
        echo "codex login --device-auth"
        exit 1
    fi
fi


# ------------------------------------------------------------
# 3. Telegram
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "   3/3 Telegram"
echo "=========================================="
echo ""

echo "→ Instaluji Agent2Telegram..."
echo ""

curl -fsSL \
https://raw.githubusercontent.com/petrludwig-collab/Agent2Telegram/main/install.sh \
| bash

echo ""
echo "=========================================="
echo "   ✅ HOTOVO"
echo "=========================================="
echo ""
echo "Codex je nainstalovaný."
echo "Agent2Telegram je nainstalovaný."
echo ""
echo "Pošli zprávu svému Telegram botovi."
echo ""
