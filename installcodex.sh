#!/usr/bin/env bash

set -Eeuo pipefail

# ============================================================
# Codex + tmux + Telegram
#
# Zdroj Telegram bridge:
#   https://github.com/tomasreminek/agenti
#
# ŽÁDNÁ runtime závislost na:
#   petrludwig-collab/Agent2Telegram
#
# Vše se instaluje bez sudo do HOME uživatele.
# Skript lze spouštět opakovaně.
# ============================================================


# ------------------------------------------------------------
# KONFIGURACE
# ------------------------------------------------------------

OWNER="tomasreminek"
REPO="agenti"
BRANCH="main"

VENDOR_PATH="vendor/Agent2Telegram"

BIN_DIR="$HOME/.local/bin"

A2T_SRC="$HOME/.agent2telegram-src"
A2T_CONFIG_DIR="$HOME/.config/agent2telegram"
A2T_CONFIG="$A2T_CONFIG_DIR/config.json"

TMP_ROOT=""

export PATH="$BIN_DIR:$PATH"


# ------------------------------------------------------------
# Pomocné funkce
# ------------------------------------------------------------

section() {

    echo ""
    echo "============================================================"
    echo "  $1"
    echo "============================================================"
    echo ""

}


fail() {

    echo ""
    echo "❌ $*" >&2
    echo ""
    exit 1

}


have() {

    command -v "$1" >/dev/null 2>&1

}


cleanup() {

    if [ -n "${TMP_ROOT:-}" ] && [ -d "$TMP_ROOT" ]; then
        rm -rf "$TMP_ROOT"
    fi

}


trap cleanup EXIT


trap '
echo ""
echo "❌ Instalace selhala na řádku $LINENO."
echo "Stejný instalační příkaz můžeš bezpečně spustit znovu."
echo ""
' ERR


# ------------------------------------------------------------
# PATH
# ------------------------------------------------------------

ensure_path() {

    mkdir -p "$BIN_DIR"

    export PATH="$BIN_DIR:$PATH"

    local PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'
    local rc


    for rc in \
        "$HOME/.profile" \
        "$HOME/.bashrc" \
        "$HOME/.zshrc"
    do

        [ -e "$rc" ] || touch "$rc" 2>/dev/null || continue

        if ! grep -Fq "$PATH_LINE" "$rc" 2>/dev/null; then
            printf '\n%s\n' "$PATH_LINE" >> "$rc"
        fi

    done

}


# ------------------------------------------------------------
# 0/5 Prostředí
# ------------------------------------------------------------

check_environment() {

    section "0/5  Kontrola prostředí"


    local missing=0
    local cmd


    for cmd in curl python3 tar uname mktemp; do

        if have "$cmd"; then

            echo "✅ $cmd"

        else

            echo "❌ Chybí: $cmd"
            missing=1

        fi

    done


    if [ "$missing" -ne 0 ]; then

        fail "V kontejneru chybí potřebné systémové nástroje."

    fi


    # Python >= 3.10

    if ! python3 - <<'PY'
import sys
raise SystemExit(0 if sys.version_info >= (3, 10) else 1)
PY
    then

        fail "Je potřeba Python 3.10 nebo novější.

Nalezeno:
$(python3 --version 2>&1)"

    fi


    echo "✅ $(python3 --version)"

    ensure_path

}


# ------------------------------------------------------------
# 1/5 Codex
# ------------------------------------------------------------

install_codex() {

    section "1/5  OpenAI Codex"


    if have codex; then

        echo "✅ Codex už je nainstalovaný:"
        codex --version || true

        return

    fi


    echo "→ Instaluji OpenAI Codex..."
    echo ""


    curl -fsSL https://chatgpt.com/codex/install.sh \
        | CODEX_NON_INTERACTIVE=1 sh


    ensure_path

    hash -r 2>/dev/null || true


    if ! have codex; then

        fail "Codex se nepodařilo nainstalovat."

    fi


    echo ""
    echo "✅ Codex nainstalován:"
    codex --version

}


# ------------------------------------------------------------
# 2/5 Login Codexu
# ------------------------------------------------------------

login_codex() {

    section "2/5  Přihlášení Codexu"


    if codex login status >/dev/null 2>&1; then

        echo "✅ Codex už je přihlášený."
        codex login status || true

        return

    fi


    echo "Codex ještě není přihlášený."
    echo ""
    echo "Teď se zobrazí Device Code."
    echo ""
    echo "Odkaz můžeš otevřít:"
    echo "• na počítači"
    echo "• v telefonu"
    echo "• v jiném prohlížeči"
    echo ""


    if [ ! -e /dev/tty ]; then

        fail "Není dostupný interaktivní terminál."

    fi


    codex login --device-auth </dev/tty


    if ! codex login status >/dev/null 2>&1; then

        fail "Přihlášení Codexu nebylo dokončeno."

    fi


    echo ""
    echo "✅ Codex přihlášen."

}


# ------------------------------------------------------------
# 3/5 tmux
# ------------------------------------------------------------

install_tmux() {

    section "3/5  tmux"


    if have tmux; then

        echo "✅ tmux už je nainstalovaný:"
        tmux -V

        return

    fi


    echo "→ tmux není nainstalovaný."
    echo "→ Instaluji ho bez sudo do:"
    echo ""
    echo "   $BIN_DIR"
    echo ""


    local MACHINE
    local ARCH
    local RELEASE_URL
    local TAG
    local VERSION
    local ASSET
    local URL
    local TMP


    MACHINE="$(uname -m)"


    case "$MACHINE" in

        x86_64|amd64)

            ARCH="x86_64"
            ;;

        aarch64|arm64)

            ARCH="arm64"
            ;;

        *)

            fail "Nepodporovaná architektura:

$MACHINE"

            ;;

    esac


    RELEASE_URL="$(
        curl -fsSL \
            -o /dev/null \
            -w '%{url_effective}' \
            https://github.com/tmux/tmux-builds/releases/latest
    )"


    TAG="${RELEASE_URL##*/}"


    case "$TAG" in

        v*)
            ;;

        *)

            fail "Nepodařilo se zjistit aktuální verzi tmux."

            ;;

    esac


    VERSION="${TAG#v}"

    ASSET="tmux-${VERSION}-linux-${ARCH}.tar.gz"

    URL="https://github.com/tmux/tmux-builds/releases/download/${TAG}/${ASSET}"


    TMP="$(mktemp -d)"


    echo "→ Stahuji tmux $VERSION..."
    echo ""


    curl -fL \
        "$URL" \
        -o "$TMP/$ASSET"


    tar -xzf \
        "$TMP/$ASSET" \
        -C "$TMP"


    if [ ! -f "$TMP/tmux" ]; then

        rm -rf "$TMP"

        fail "Ve staženém archivu chybí tmux."

    fi


    cp "$TMP/tmux" "$BIN_DIR/tmux"

    chmod 0755 "$BIN_DIR/tmux"


    rm -rf "$TMP"


    hash -r 2>/dev/null || true


    if ! have tmux; then

        fail "Instalace tmux se nezdařila."

    fi


    echo ""
    echo "✅ tmux:"
    tmux -V

}


# ------------------------------------------------------------
# Stažení VLASTNÍHO Agent2Telegram
#
# Zdroj je pouze:
# github.com/tomasreminek/agenti
# ------------------------------------------------------------

install_agent2telegram() {

    section "4/5  Telegram bridge"


    echo "→ Instaluji Telegram bridge z tvého repozitáře:"
    echo ""
    echo "   $OWNER/$REPO"
    echo ""


    TMP_ROOT="$(mktemp -d)"


    local ARCHIVE
    local SOURCE
    local TOP_DIR


    ARCHIVE="$TMP_ROOT/agenti.tar.gz"


    # --------------------------------------------------------
    # Stáhneme TVŮJ repo
    #
    # Žádný petrludwig-collab.
    # --------------------------------------------------------

    curl -fL \
        "https://github.com/${OWNER}/${REPO}/archive/refs/heads/${BRANCH}.tar.gz?x=$(date +%s)" \
        -o "$ARCHIVE"


    mkdir -p "$TMP_ROOT/extracted"


    tar -xzf "$ARCHIVE" \
        -C "$TMP_ROOT/extracted"


    TOP_DIR="$(
        find "$TMP_ROOT/extracted" \
            -mindepth 1 \
            -maxdepth 1 \
            -type d \
            | head -n 1
    )"


    if [ -z "$TOP_DIR" ]; then

        fail "Stažený repozitář se nepodařilo rozbalit."

    fi


    SOURCE="$TOP_DIR/$VENDOR_PATH"


    if [ ! -d "$SOURCE/agent2telegram" ]; then

        echo ""
        echo "Hledal jsem:"
        echo ""
        echo "$SOURCE/agent2telegram"
        echo ""

        fail "Ve tvém repozitáři chybí:

$VENDOR_PATH/agent2telegram"

    fi


    if [ ! -f "$SOURCE/agent2telegram/__main__.py" ]; then

        fail "Vendorovaný Agent2Telegram není kompletní."

    fi


    # --------------------------------------------------------
    # Licence
    # --------------------------------------------------------

    if [ ! -f "$SOURCE/LICENSE" ]; then

        fail "Chybí LICENSE.

Při distribuci Agent2Telegram musí zůstat zachována
MIT licence původního projektu."

    fi


    # --------------------------------------------------------
    # Nahradíme starý source snapshot
    # --------------------------------------------------------

    rm -rf "$A2T_SRC"

    mkdir -p "$A2T_SRC"


    cp -a \
        "$SOURCE/." \
        "$A2T_SRC/"


    # --------------------------------------------------------
    # Launcher
    # --------------------------------------------------------

    local PYTHON_BIN

    PYTHON_BIN="$(command -v python3)"


    cat > "$BIN_DIR/agent2telegram" <<EOF
#!/bin/sh

export PATH="\$HOME/.local/bin:\$PATH"

exec env \
    PYTHONPATH="$A2T_SRC" \
    "$PYTHON_BIN" \
    -m agent2telegram \
    "\$@"
EOF


    chmod 0755 "$BIN_DIR/agent2telegram"


    hash -r 2>/dev/null || true


    if ! have agent2telegram; then

        fail "Nepodařilo se vytvořit příkaz agent2telegram."

    fi


    echo "✅ Telegram bridge nainstalovaný."
    echo ""
    echo "Zdroj:"
    echo "$A2T_SRC"

}


# ------------------------------------------------------------
# Telegram setup
# ------------------------------------------------------------

setup_telegram() {

    section "5/5  Propojení s Telegramem"


    mkdir -p "$A2T_CONFIG_DIR"


    # --------------------------------------------------------
    # Existující konfigurace
    # --------------------------------------------------------

    if [ -f "$A2T_CONFIG" ]; then

        echo "Telegram už byl na tomto účtu nastavovaný."
        echo ""

        echo "1) Ponechat současné nastavení"
        echo "2) Nastavit Telegram znovu"
        echo ""

        local ANSWER="1"


        if [ -e /dev/tty ]; then

            read -r \
                -p "Vyber [1/2] (výchozí 1): " \
                ANSWER \
                </dev/tty || true

        fi


        ANSWER="${ANSWER:-1}"


        # ----------------------------------------------------
        # Existující config
        # ----------------------------------------------------

        if [ "$ANSWER" != "2" ]; then

            echo ""
            echo "→ Kontroluji současné nastavení..."
            echo ""

            if agent2telegram doctor; then

                echo ""
                echo "✅ Telegram je nakonfigurovaný."

                return

            fi


            echo ""
            echo "⚠️ Současná konfigurace není kompletní."
            echo ""
            echo "Spouštím setup znovu..."
            echo ""

        else

            echo ""
            echo "→ Resetuji staré Telegram nastavení..."
            echo ""


            # Vestavěný uninstall odstraní:
            # config + state + bridge proces + launcher + source

            agent2telegram uninstall --yes || true


            # My ale chceme source znovu z NAŠEHO repa.

            install_agent2telegram


            mkdir -p "$A2T_CONFIG_DIR"

        fi

    fi


    # --------------------------------------------------------
    # Nový setup
    # --------------------------------------------------------

    echo ""
    echo "Teď proběhne propojení s Telegramem."
    echo ""
    echo "Připrav si Telegram Bot Token."
    echo ""
    echo "Bota vytvoříš pomocí:"
    echo ""
    echo "   @BotFather"
    echo ""
    echo "a příkazu:"
    echo ""
    echo "   /newbot"
    echo ""


    if [ ! -e /dev/tty ]; then

        fail "Telegram setup potřebuje interaktivní terminál."

    fi


    agent2telegram setup </dev/tty


    echo ""
    echo "→ Kontroluji konfiguraci..."
    echo ""


    if agent2telegram doctor; then

        echo ""
        echo "✅ Telegram je připravený."

    else

        echo ""
        echo "⚠️ Setup proběhl, ale diagnostika našla problém."
        echo ""
        echo "Spusť:"
        echo ""
        echo "agent2telegram doctor"

    fi

}


# ------------------------------------------------------------
# MAIN
# ------------------------------------------------------------

main() {

    section "OpenAI Codex + Telegram"


    echo "Instalace:"
    echo ""
    echo "• nepotřebuje sudo"
    echo "• nepotřebuje root"
    echo "• lze ji spustit opakovaně"
    echo "• Telegram bridge pochází z tvého GitHubu"
    echo ""


    check_environment

    install_codex

    login_codex

    install_tmux

    install_agent2telegram

    setup_telegram


    section "🎉 HOTOVO"


    echo "Codex:"
    codex --version || true

    echo ""

    echo "tmux:"
    tmux -V || true

    echo ""

    echo "Telegram:"
    echo "agent2telegram doctor"

    echo ""

    echo "Spuštění:"
    echo "agent2telegram run"

    echo ""


    if [ -f /.dockerenv ]; then

        echo "⚠️ Běžíš uvnitř Docker kontejneru."
        echo ""
        echo "Při jeho smazání/redeployi může zmizet:"
        echo ""
        echo "• ~/.local"
        echo "• ~/.codex"
        echo "• ~/.config/agent2telegram"
        echo "• ~/.agent2telegram-src"
        echo ""
        echo "Tyto adresáře by měly být na persistentním volume."
        echo ""

    fi

}


main "$@"
