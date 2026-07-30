#!/usr/bin/env bash

set -euo pipefail

echo ""
echo "=========================================="
echo "   OpenAI Codex + Telegram instalace"
echo "=========================================="
echo ""

# ------------------------------------------------------------
# 1. Základní nástroje
# ------------------------------------------------------------

install_dependencies() {
    if command -v apt-get >/dev/null 2>&1; then
        echo "→ Kontroluji systémové balíčky..."

        if [ "$(id -u)" -eq 0 ]; then
            APT="apt-get"
        elif command -v sudo >/dev/null 2>&1; then
            APT="sudo apt-get"
        else
            echo "❌ Pro instalaci balíčků potřebuji root nebo sudo."
            exit 1
        fi

        $APT update
        $APT install -y \
            curl \
            ca-certificates \
            git \
            python3 \
            tmux
    fi
}

install_dependencies


# ------------------------------------------------------------
# 2. Kontrola Pythonu
# Agent2Telegram vyžaduje Python 3.10+
# ------------------------------------------------------------

if ! command -v python3 >/dev/null 2>&1; then
    echo "❌ Python 3 není nainstalovaný."
    exit 1
fi

if ! python3 - <<'PY'
import sys
sys.exit(0 if sys.version_info >= (3, 10) else 1)
PY
then
    echo "❌ Agent2Telegram potřebuje Python 3.10 nebo novější."
    python3 --version
    exit 1
fi

echo "✅ $(python3 --version)"


# ------------------------------------------------------------
# 3. Instalace OpenAI Codex
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "   1/3 Instalace OpenAI Codex"
echo "=========================================="
echo ""

if command -v codex >/dev/null 2>&1; then

    echo "✅ Codex už je nainstalovaný:"
    codex --version

else

    echo "→ Instaluji nejnovější OpenAI Codex CLI..."

    curl -fsSL https://chatgpt.com/codex/install.sh \
        | CODEX_NON_INTERACTIVE=1 sh

fi


# Codex standalone installer používá ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

if ! command -v codex >/dev/null 2>&1; then
    echo "❌ Codex se nepodařilo nainstalovat."
    exit 1
fi

echo ""
echo "✅ Codex připraven:"
codex --version


# ------------------------------------------------------------
# 4. Přihlášení Codexu
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "   2/3 Přihlášení do ChatGPT"
echo "=========================================="
echo ""

if codex login status >/dev/null 2>&1; then

    echo "✅ Codex je už přihlášený."

else

    echo "Codex je potřeba propojit s účtem ChatGPT."
    echo ""
    echo "Otevře se Device Code přihlášení."
    echo "Odkaz můžeš otevřít na svém počítači nebo telefonu."
    echo ""

    if [ -e /dev/tty ]; then
        codex login --device-auth </dev/tty
    else
        echo "❌ Není dostupný interaktivní terminál."
        echo "Spusť:"
        echo ""
        echo "    codex login --device-auth"
        echo ""
        exit 1
    fi

fi


# Ověření přihlášení

if ! codex login status >/dev/null 2>&1; then
    echo "❌ Codex není přihlášený."
    exit 1
fi

echo "✅ ChatGPT účet propojen."


# ------------------------------------------------------------
# 5. Agent2Telegram
# ------------------------------------------------------------

echo ""
echo "=========================================="
echo "   3/3 Propojení Codexu s Telegramem"
echo "=========================================="
echo ""

echo "Teď vytvoř Telegram bota přes @BotFather."
echo ""
echo "1. Otevři Telegram"
echo "2. Najdi @BotFather"
echo "3. Napiš /newbot"
echo "4. Vytvoř bota"
echo "5. Zkopíruj jeho TOKEN"
echo ""
echo "Instalační průvodce si ho za chvíli vyžádá."
echo ""

read -r -p "Až budeš připravený, stiskni ENTER..." </dev/tty


# Oficiální Agent2Telegram installer
curl -fsSL \
    https://raw.githubusercontent.com/petrludwig-collab/Agent2Telegram/main/install.sh \
    | bash


echo ""
echo "=========================================="
echo "   ✅ Hotovo"
echo "=========================================="
echo ""
echo "Codex je nainstalovaný a propojený s Telegramem."
echo ""
echo "Codex:"
codex --version
echo ""
echo "Telegram bridge:"
echo "    agent2telegram run"
echo ""
echo "Diagnostika:"
echo "    agent2telegram doctor"
echo ""
