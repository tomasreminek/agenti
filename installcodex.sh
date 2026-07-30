#!/usr/bin/env bash

set -Eeuo pipefail

# ============================================================
# OpenAI Codex + Telegram
#
# Instalátor pro:
#   https://github.com/tomasreminek/agenti
#
# Obsahuje:
#   - OpenAI Codex CLI
#   - přihlášení přes ChatGPT
#   - tmux bez sudo/root
#   - vlastní kopii Agent2Telegram
#   - český instalační průvodce
#
# Lze bezpečně spouštět opakovaně.
# ============================================================


# ============================================================
# KONFIGURACE
# ============================================================

OWNER="tomasreminek"
REPO="agenti"
BRANCH="main"

VENDOR_PATH="vendor/Agent2Telegram"

BIN_DIR="$HOME/.local/bin"
A2T_SRC="$HOME/.agent2telegram-src"
A2T_CONFIG="$HOME/.config/agent2telegram/config.json"

TMP_ROOT=""

export PATH="$BIN_DIR:$PATH"


# ============================================================
# POMOCNÉ FUNKCE
# ============================================================

sekce() {

    echo ""
    echo "============================================================"
    echo "  $1"
    echo "============================================================"
    echo ""

}


chyba() {

    echo ""
    echo "❌ $*" >&2
    echo ""
    exit 1

}


existuje() {

    command -v "$1" >/dev/null 2>&1

}


uklid() {

    if [ -n "${TMP_ROOT:-}" ] && [ -d "$TMP_ROOT" ]; then
        rm -rf "$TMP_ROOT"
    fi

}


trap uklid EXIT


trap '
echo ""
echo "❌ Instalace byla přerušena chybou."
echo ""
echo "Nevadí — stejný instalační příkaz můžeš spustit znovu."
echo ""
' ERR


# ============================================================
# PATH
# ============================================================

nastav_path() {

    mkdir -p "$BIN_DIR"

    export PATH="$BIN_DIR:$PATH"

    local PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'
    local soubor


    for soubor in \
        "$HOME/.profile" \
        "$HOME/.bashrc" \
        "$HOME/.zshrc"
    do

        [ -e "$soubor" ] || touch "$soubor" 2>/dev/null || continue

        if ! grep -Fq "$PATH_LINE" "$soubor" 2>/dev/null; then
            printf '\n%s\n' "$PATH_LINE" >> "$soubor"
        fi

    done

}


# ============================================================
# 0/5 KONTROLA PROSTŘEDÍ
# ============================================================

zkontroluj_prostredi() {

    sekce "0/5  Kontrola prostředí"


    local chyba_nalezena=0
    local prikaz


    for prikaz in curl python3 tar uname mktemp; do

        if existuje "$prikaz"; then

            echo "✅ $prikaz"

        else

            echo "❌ Chybí: $prikaz"
            chyba_nalezena=1

        fi

    done


    if [ "$chyba_nalezena" -ne 0 ]; then

        chyba "V tomto prostředí chybí některé základní systémové nástroje."

    fi


    # --------------------------------------------------------
    # Python 3.10+
    # --------------------------------------------------------

    if ! python3 - <<'PY'
import sys
raise SystemExit(0 if sys.version_info >= (3, 10) else 1)
PY
    then

        chyba "Agent2Telegram potřebuje Python 3.10 nebo novější.

Nalezená verze:
$(python3 --version 2>&1)"

    fi


    echo "✅ $(python3 --version)"


    nastav_path

}


# ============================================================
# 1/5 OPENAI CODEX
# ============================================================

nainstaluj_codex() {

    sekce "1/5  OpenAI Codex"


    if existuje codex; then

        echo "✅ Codex už je nainstalovaný:"
        codex --version || true

        return

    fi


    echo "→ Instaluji nejnovější OpenAI Codex CLI..."
    echo ""


    curl -fsSL https://chatgpt.com/codex/install.sh \
        | CODEX_NON_INTERACTIVE=1 sh


    nastav_path

    hash -r 2>/dev/null || true


    if ! existuje codex; then

        chyba "Codex se nepodařilo nainstalovat."

    fi


    echo ""
    echo "✅ Codex byl nainstalován:"
    codex --version

}


# ============================================================
# 2/5 PŘIHLÁŠENÍ CODEXU
# ============================================================

prihlas_codex() {

    sekce "2/5  Přihlášení do ChatGPT"


    if codex login status >/dev/null 2>&1; then

        echo "✅ Codex už je přihlášený k ChatGPT."

        return

    fi


    echo "Codex ještě není přihlášený."
    echo ""
    echo "Teď se spustí přihlášení pomocí Device Code."
    echo ""
    echo "Zobrazený odkaz můžeš otevřít:"
    echo ""
    echo "  • na počítači"
    echo "  • v telefonu"
    echo "  • v jiném prohlížeči"
    echo ""
    echo "Po přihlášení se vrať sem."
    echo ""


    if [ ! -e /dev/tty ]; then

        chyba "Není dostupný interaktivní terminál pro přihlášení."

    fi


    codex login --device-auth </dev/tty


    if ! codex login status >/dev/null 2>&1; then

        chyba "Přihlášení Codexu nebylo dokončeno."

    fi


    echo ""
    echo "✅ Codex je přihlášený."

}


# ============================================================
# 3/5 TMUX BEZ SUDO
# ============================================================

nainstaluj_tmux() {

    sekce "3/5  tmux"


    if existuje tmux; then

        echo "✅ tmux už je nainstalovaný:"
        tmux -V

        return

    fi


    echo "tmux není nainstalovaný."
    echo ""
    echo "→ Instaluji statickou verzi tmux."
    echo "→ Není potřeba sudo ani root."
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

            chyba "Nepodporovaná architektura procesoru:

$MACHINE"

            ;;

    esac


    echo "→ Zjišťuji nejnovější stabilní verzi tmux..."


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

            chyba "Nepodařilo se zjistit nejnovější verzi tmux."

            ;;

    esac


    VERSION="${TAG#v}"

    ASSET="tmux-${VERSION}-linux-${ARCH}.tar.gz"

    URL="https://github.com/tmux/tmux-builds/releases/download/${TAG}/${ASSET}"


    TMP="$(mktemp -d)"


    echo "→ Stahuji tmux $VERSION pro $ARCH..."
    echo ""


    curl -fL \
        "$URL" \
        -o "$TMP/$ASSET"


    tar -xzf \
        "$TMP/$ASSET" \
        -C "$TMP"


    if [ ! -f "$TMP/tmux" ]; then

        rm -rf "$TMP"

        chyba "Ve staženém balíčku nebyla nalezena binárka tmux."

    fi


    mkdir -p "$BIN_DIR"


    cp \
        "$TMP/tmux" \
        "$BIN_DIR/tmux"


    chmod 0755 \
        "$BIN_DIR/tmux"


    rm -rf "$TMP"


    hash -r 2>/dev/null || true


    if ! existuje tmux; then

        chyba "Instalace tmux se nezdařila."

    fi


    echo ""
    echo "✅ tmux byl nainstalován:"
    tmux -V

}


# ============================================================
# POČEŠTĚNÍ AGENT2TELEGRAM
#
# Originální zdroj zůstává ve vendor adresáři nedotčený.
# Překládáme instalovanou kopii v ~/.agent2telegram-src.
# ============================================================

pocesti_agent2telegram() {

    echo "→ Přepínám Agent2Telegram do češtiny..."


    python3 - "$A2T_SRC" <<'PY'

from pathlib import Path
import sys

root = Path(sys.argv[1])

wizard = root / "agent2telegram" / "wizard.py"
attach = root / "agent2telegram" / "attach.py"


# ============================================================
# INSTALAČNÍ PRŮVODCE
# ============================================================

text = wizard.read_text(encoding="utf-8")


replacements = [

    (
        'd = "Y/n" if default_yes else "y/N"',
        'd = "A/n" if default_yes else "a/N"'
    ),

    (
        'return ans in ("y", "yes")',
        'return ans in ("a", "ano", "y", "yes")'
    ),


    # --------------------------------------------------------
    # Krok 1
    # --------------------------------------------------------

    (
        '── Step 1/3 · Which agent do you want to connect? ──',
        '── Krok 1/3 · Kterého AI agenta chceš připojit? ──'
    ),

    (
        '"✓ installed" if found else "· not found on PATH"',
        '"✓ nainstalován" if found else "· nebyl nalezen"'
    ),

    (
        '_ask("Pick a number", default)',
        '_ask("Vyber číslo", default)'
    ),

    (
        """if not a.detect() and not _yes(f"'{a.binary}' isn't on PATH. Use it anyway?"):""",
        """if not a.detect() and not _yes(f"'{a.binary}' nebyl nalezen. Přesto ho použít?"):"""
    ),

    (
        'print("Please enter a valid number.")',
        'print("Zadej prosím platné číslo.")'
    ),


    # --------------------------------------------------------
    # Vytvoření tmux relace
    # --------------------------------------------------------

    (
        'print(f" launched: {launch}")',
        'print(f" spuštěno: {launch}")'
    ),

    (
        'print(f" ✗ couldn\'t create the session: {e}")',
        'print(f" ✗ nepodařilo se vytvořit relaci: {e}")'
    ),


    # --------------------------------------------------------
    # Krok 2
    # --------------------------------------------------------

    (
        '── Step 2/3 · Which tmux session should I drive? ──',
        '── Krok 2/3 · Kterou relaci tmux chceš použít? ──'
    ),

    (
        " ⚠️ tmux isn't installed. Attach mode drives a tmux session — install tmux first.",
        " ⚠️ tmux není nainstalovaný. Nejprve je potřeba tmux nainstalovat."
    ),

    (
        '"tmux session name to use anyway"',
        '"Název relace tmux"'
    ),

    (
        'print(f" n) create a NEW session and launch {agent_cls.label} in it")',
        'print(f" n) vytvořit NOVOU relaci a spustit v ní {agent_cls.label}")'
    ),

    (
        '''_ask("Pick a number, or 'n' for new", "n" if not sessions else "1")''',
        '''_ask("Vyber číslo, nebo napiš 'n' pro novou relaci", "n" if not sessions else "1")'''
    ),

    (
        '''name = _ask("Name for the new session", "lana")''',
        '''name = _ask("Název nové relace", "codex")'''
    ),

    (
        '''print(f" ✓ created '{name}' and started {agent_cls.label} in it.")''',
        '''print(f" ✓ relace '{name}' vytvořena a {agent_cls.label} byl spuštěn.")'''
    ),

    (
        '''print("Please enter a valid number or 'n'.")''',
        '''print("Zadej platné číslo nebo 'n'.")'''
    ),


    # --------------------------------------------------------
    # Krok 3
    # --------------------------------------------------------

    (
        '── Step 3/3 · Connect Telegram ──',
        '── Krok 3/3 · Připojení Telegramu ──'
    ),

    (
        'Create a bot with @BotFather and paste its token below (hidden as you type).',
        'Vytvoř bota přes @BotFather pomocí /newbot a níže vlož jeho token. Token bude při psaní skrytý.'
    ),

    (
        '"Telegram bot token"',
        '"Token Telegram bota"'
    ),

    (
        '''print(f" ✓ token valid — bot is @{me.get('username')}")''',
        '''print(f" ✓ token je platný — nalezen bot @{me.get('username')}")'''
    ),

    (
        '''print(f" ✗ rejected by Telegram: {e}")''',
        '''print(f" ✗ Telegram token odmítl: {e}")'''
    ),

    (
        '''print(f"\\nOpen Telegram, message @{bot_username} anything (e.g. 'hi') — I'll detect your id.")''',
        '''print(f"\\nOtevři Telegram a pošli botovi @{bot_username} libovolnou zprávu. Podle ní zjistím tvoje Telegram ID.")'''
    ),

    (
        '''input("Press Enter once you've sent it… ")''',
        '''input("Až zprávu odešleš, stiskni ENTER… ")'''
    ),

    (
        '''print(f" (couldn't read updates: {e})")''',
        '''print(f" (nepodařilo se načíst zprávy z Telegramu: {e})")'''
    ),

    (
        '''or "you"''',
        '''or "uživatel"'''
    ),

    (
        '''print(f" ✓ authorized {who} (id {frm['id']})")''',
        '''print(f" ✓ autorizován uživatel {who} (ID {frm['id']})")'''
    ),

    (
        '''_ask("Couldn't auto-detect. Enter your Telegram user id manually")''',
        '''_ask("ID se nepodařilo zjistit automaticky. Zadej svoje Telegram ID ručně")'''
    ),


    # --------------------------------------------------------
    # Hlavní setup
    # --------------------------------------------------------

    (
        '=== Agent2Telegram setup ===',
        '=== Nastavení Codexu pro Telegram ==='
    ),

    (
        '''_yes(f"A config already exists at {existing}. Overwrite?")''',
        '''_yes(f"Konfigurace už existuje v {existing}. Chceš ji přepsat?")'''
    ),

    (
        'Aborted — keeping the existing config.',
        'Nastavení nebylo změněno — ponechávám současnou konfiguraci.'
    ),

    (
        'Enable voice messages via ElevenLabs Scribe?',
        'Chceš zapnout hlasové zprávy přes ElevenLabs Scribe?'
    ),

    (
        'ElevenLabs API key (hidden)',
        'ElevenLabs API klíč (skrytý)'
    ),

    (
        '''print(f"\\n✓ Saved config to {path} (permissions 0600).")''',
        '''print(f"\\n✓ Konfigurace byla uložena do {path}.")'''
    ),

    (
        ' ✓ Codex needs no hook — turn boundaries come from its rollout log.',
        ' ✓ Codex je připraven — není potřeba žádný další hook.'
    ),

    (
        "⚠️ No authorized user — add your id to 'allowed_user_ids' before using the bot.",
        "⚠️ Nebyl autorizován žádný uživatel. Před použitím bota je potřeba přidat Telegram ID."
    ),

    (
        'All set! Starting the bridge in the background…',
        'Všechno je nastavené. Spouštím propojení s Telegramem na pozadí…'
    ),

    (
        '''print(f" ✓ running — logs at {log}")''',
        '''print(f" ✓ propojení běží — záznam je v {log}")'''
    ),

    (
        '''print(f" Message @{me.get('username')} on Telegram to test it.")''',
        '''print(f" Napiš botovi @{me.get('username')} na Telegramu a vyzkoušej ho.")'''
    ),

    (
        ' (Stop it anytime with: python3 -m agent2telegram uninstall)',
        ' (Propojení lze později vypnout příkazem: agent2telegram uninstall)'
    ),

]


for old, new in replacements:
    text = text.replace(old, new)


wizard.write_text(text, encoding="utf-8")


# ============================================================
# ZÁKLADNÍ ZPRÁVY TELEGRAM BOTA
# ============================================================

text = attach.read_text(encoding="utf-8")


replacements = [

    (
        '"Intro and what you can send"',
        '"Úvod a možnosti bota"'
    ),

    (
        '"Connection and voice status"',
        '"Stav připojení a hlasových zpráv"'
    ),

    (
        '"Enable voice (your ElevenLabs API key)"',
        '"Zapnout hlas pomocí ElevenLabs API klíče"'
    ),

    (
        '"Show your Telegram id"',
        '"Zobrazit moje Telegram ID"'
    ),

    (
        '"⛔ Not authorized."',
        '"⛔ Tento Telegram účet není autorizovaný."'
    ),

    (
        '''voice = "on" if self.cfg.elevenlabs_api_key else "off — enable with /setkey"''',
        '''voice = "zapnuto" if self.cfg.elevenlabs_api_key else "vypnuto — zapneš příkazem /setkey"'''
    ),

    (
        '''f"👋 You're connected to a live *{agent}* session via Agent2Telegram.\\n\\n"''',
        '''f"👋 Jsi připojený k běžící relaci *{agent}* přes Telegram.\\n\\n"'''
    ),

    (
        '''"Just send a message — it goes straight to the agent and you'll see typing, live "''',
        '''"Stačí poslat zprávu — odešle se přímo agentovi. Uvidíš průběh práce, "'''
    ),

    (
        '''"progress, what tools it runs, and the reply. You can also send *photos* and "''',
        '''"používané nástroje i výslednou odpověď. Můžeš posílat také *fotky* a "'''
    ),

    (
        '''"*files*, and react with ❤️ as quick feedback.\\n\\n"''',
        '''"*soubory* a pomocí ❤️ dát rychlou zpětnou vazbu.\\n\\n"'''
    ),

    (
        '''f"🎤 Voice transcription: {voice}.\\n\\n"''',
        '''f"🎤 Přepis hlasových zpráv: {voice}.\\n\\n"'''
    ),

    (
        '''"Commands: /help · /status · /id · /setkey"''',
        '''"Příkazy: /help · /status · /id · /setkey"'''
    ),

    (
        '''f"Your Telegram id: `{chat_id}`"''',
        '''f"Tvoje Telegram ID: `{chat_id}`"'''
    ),

    (
        '''f"✅ Connected — *{agent}* in tmux session `{self.cfg.tmux_session}`.\\n"''',
        '''f"✅ Připojeno — *{agent}* běží v relaci tmux `{self.cfg.tmux_session}`.\\n"'''
    ),

    (
        '''f"🎤 Voice (ElevenLabs): {voice}"''',
        '''f"🎤 Hlasové zprávy (ElevenLabs): {voice}"'''
    ),

    (
        '''"Usage: `/setkey <your ElevenLabs API key>` — enables voice-message transcription.\\n"''',
        '''"Použití: `/setkey <tvůj ElevenLabs API klíč>` — zapne přepis hlasových zpráv.\\n"'''
    ),

    (
        '''"I'll delete your message right after so the key isn't left in the chat."''',
        '''"Zprávu s klíčem hned smažu, aby klíč nezůstal v historii chatu."'''
    ),

    (
        '''"✅ Voice transcription enabled — key saved. I deleted your message so the key "''',
        '''"✅ Přepis hlasových zpráv je zapnutý — klíč byl uložen. Zprávu s klíčem jsem smazal, aby "'''
    ),

    (
        '''"isn't left in the chat history. Send a voice note to try it."''',
        '''"nezůstal v historii chatu. Teď můžeš poslat hlasovou zprávu."'''
    ),

]


for old, new in replacements:
    text = text.replace(old, new)


attach.write_text(text, encoding="utf-8")

print("✅ Česká lokalizace Agent2Telegram byla použita.")

PY

}


# ============================================================
# 4/5 INSTALACE VLASTNÍHO AGENT2TELEGRAM
# ============================================================

nainstaluj_agent2telegram() {

    sekce "4/5  Telegram bridge"


    echo "→ Instaluji Agent2Telegram z tvého repozitáře:"
    echo ""
    echo "   github.com/$OWNER/$REPO"
    echo ""
    echo "→ Nepoužívám repozitář petrludwig-collab."
    echo ""


    TMP_ROOT="$(mktemp -d)"


    local ARCHIVE
    local EXTRACTED
    local REPO_ROOT
    local SOURCE
    local PYTHON_BIN


    ARCHIVE="$TMP_ROOT/agenti.tar.gz"

    EXTRACTED="$TMP_ROOT/rozbaleno"


    mkdir -p "$EXTRACTED"


    echo "→ Stahuji aktuální verzi..."
    echo ""


    curl -fL \
        "https://github.com/${OWNER}/${REPO}/archive/refs/heads/${BRANCH}.tar.gz?x=$(date +%s)" \
        -o "$ARCHIVE"


    echo "→ Rozbaluji..."
    echo ""


    tar -xzf \
        "$ARCHIVE" \
        -C "$EXTRACTED"


    REPO_ROOT="$EXTRACTED/${REPO}-${BRANCH}"

    SOURCE="$REPO_ROOT/$VENDOR_PATH"


    if [ ! -d "$SOURCE/agent2telegram" ]; then

        chyba "V repozitáři nebyl nalezen:

$VENDOR_PATH/agent2telegram"

    fi


    if [ ! -f "$SOURCE/agent2telegram/__main__.py" ]; then

        chyba "Kopie Agent2Telegram není kompletní."

    fi


    if [ ! -f "$SOURCE/LICENSE" ]; then

        chyba "Ve vendor/Agent2Telegram chybí LICENSE."

    fi


    echo "→ Kopíruji Agent2Telegram..."
    echo ""


    rm -rf "$A2T_SRC"

    mkdir -p "$A2T_SRC"


    cp -a \
        "$SOURCE/." \
        "$A2T_SRC/"


    # --------------------------------------------------------
    # Česká lokalizace
    # --------------------------------------------------------

    pocesti_agent2telegram


    # --------------------------------------------------------
    # Launcher
    # --------------------------------------------------------

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


    chmod 0755 \
        "$BIN_DIR/agent2telegram"


    hash -r 2>/dev/null || true


    if ! existuje agent2telegram; then

        chyba "Nepodařilo se vytvořit příkaz agent2telegram."

    fi


    echo ""
    echo "✅ Agent2Telegram byl nainstalován."
    echo ""

}


# ============================================================
# 5/5 NASTAVENÍ TELEGRAMU
# ============================================================

nastav_telegram() {

    sekce "5/5  Propojení Codexu s Telegramem"


    echo "Teď proběhne český průvodce propojením."
    echo ""
    echo "Budeš potřebovat Telegram bota."
    echo ""
    echo "Pokud ho ještě nemáš:"
    echo ""
    echo "  1. Otevři Telegram"
    echo "  2. Najdi @BotFather"
    echo "  3. Pošli příkaz /newbot"
    echo "  4. Vytvoř bota"
    echo "  5. Zkopíruj jeho token"
    echo ""


    if [ -f "$A2T_CONFIG" ]; then

        echo "ℹ️ Našel jsem existující nastavení Telegramu."
        echo ""
        echo "Průvodce se zeptá, jestli ho chceš přepsat."
        echo ""
        echo "Pokud byla předchozí instalace přerušena,"
        echo "odpověz:"
        echo ""
        echo "    a"
        echo ""
        echo "tedy ANO."
        echo ""

    fi


    if [ ! -e /dev/tty ]; then

        chyba "Pro nastavení Telegramu je potřeba interaktivní terminál."

    fi


    agent2telegram setup </dev/tty


    echo ""
    echo "✅ Průvodce byl dokončen."

}


# ============================================================
# HOTOVO
# ============================================================

hotovo() {

    sekce "🎉 Instalace dokončena"


    echo "OpenAI Codex:"
    echo ""

    codex --version || true


    echo ""
    echo "tmux:"
    echo ""

    tmux -V || true


    echo ""
    echo "Telegram bridge:"
    echo ""

    echo "  agent2telegram"


    echo ""
    echo "Užitečné příkazy:"
    echo ""

    echo "  agent2telegram run"
    echo "      spustí propojení s Telegramem"

    echo ""

    echo "  agent2telegram setup"
    echo "      znovu nastaví Telegram"

    echo ""

    echo "  agent2telegram doctor"
    echo "      provede diagnostiku"

    echo ""

    echo "  codex"
    echo "      spustí Codex přímo v terminálu"

    echo ""


    if [ -f /.dockerenv ]; then

        echo "------------------------------------------------------------"
        echo "⚠️  POZOR: Běžíš uvnitř Docker kontejneru"
        echo "------------------------------------------------------------"
        echo ""
        echo "Při odstranění nebo novém vytvoření kontejneru může"
        echo "instalace zmizet, pokud HOME není na persistentním volume."
        echo ""
        echo "Důležité adresáře:"
        echo ""
        echo "  $HOME/.local"
        echo "  $HOME/.codex"
        echo "  $HOME/.config/agent2telegram"
        echo "  $HOME/.agent2telegram-src"
        echo ""

    fi

}


# ============================================================
# MAIN
# ============================================================

main() {

    sekce "OpenAI Codex + Telegram"


    echo "Tento instalátor:"
    echo ""
    echo "  ✓ nepotřebuje sudo"
    echo "  ✓ nepotřebuje root"
    echo "  ✓ nainstaluje Codex"
    echo "  ✓ nainstaluje tmux"
    echo "  ✓ použije Agent2Telegram z tvého GitHubu"
    echo "  ✓ počeští instalačního průvodce"
    echo "  ✓ lze ho bezpečně spustit znovu"
    echo ""


    zkontroluj_prostredi

    nainstaluj_codex

    prihlas_codex

    nainstaluj_tmux

    nainstaluj_agent2telegram

    nastav_telegram

    hotovo

}


main "$@"
