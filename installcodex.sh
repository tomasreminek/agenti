# ------------------------------------------------------------
# Instalace tmux bez sudo
# ------------------------------------------------------------

echo ""
echo "→ Kontroluji tmux..."

if command -v tmux >/dev/null 2>&1; then

    echo "✅ tmux už je nainstalovaný:"
    tmux -V

else

    echo "→ tmux není nainstalovaný."
    echo "→ Instaluji tmux do ~/.local/bin bez sudo..."

    mkdir -p "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"

    case "$(uname -m)" in
        x86_64|amd64)
            TMUX_ARCH="x86_64"
            ;;
        aarch64|arm64)
            TMUX_ARCH="arm64"
            ;;
        *)
            echo "❌ Nepodporovaná architektura: $(uname -m)"
            exit 1
            ;;
    esac

    # Zjisti nejnovější stabilní verzi tmux-builds
    LATEST_URL="$(
        curl -fsSL \
            -o /dev/null \
            -w '%{url_effective}' \
            https://github.com/tmux/tmux-builds/releases/latest
    )"

    TMUX_TAG="${LATEST_URL##*/}"
    TMUX_VERSION="${TMUX_TAG#v}"

    if [ -z "$TMUX_VERSION" ]; then
        echo "❌ Nepodařilo se zjistit nejnovější verzi tmux."
        exit 1
    fi

    TMUX_FILE="tmux-${TMUX_VERSION}-linux-${TMUX_ARCH}.tar.gz"
    TMUX_URL="https://github.com/tmux/tmux-builds/releases/download/${TMUX_TAG}/${TMUX_FILE}"

    TMP_DIR="$(mktemp -d)"

    echo "→ Stahuji tmux ${TMUX_VERSION} (${TMUX_ARCH})..."

    curl -fL "$TMUX_URL" \
        -o "$TMP_DIR/$TMUX_FILE"

    tar -xzf "$TMP_DIR/$TMUX_FILE" \
        -C "$TMP_DIR"

    if [ ! -f "$TMP_DIR/tmux" ]; then
        echo "❌ V archivu nebyla nalezena binárka tmux."
        rm -rf "$TMP_DIR"
        exit 1
    fi

    cp "$TMP_DIR/tmux" "$HOME/.local/bin/tmux"
    chmod +x "$HOME/.local/bin/tmux"

    rm -rf "$TMP_DIR"

    hash -r

    if ! command -v tmux >/dev/null 2>&1; then
        echo "❌ Instalace tmux se nezdařila."
        exit 1
    fi

    echo "✅ tmux nainstalován:"
    tmux -V
fi
