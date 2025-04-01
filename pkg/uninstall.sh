#!/bin/bash
set -euo pipefail

APP_NAME="git-ask-pass"
INSTALL_PATH="${XDG_BIN_HOME:-$HOME/.local/bin}"
TARGET="$INSTALL_PATH/$APP_NAME"

echo "Uninstalling $APP_NAME..."

# Remove binary if it exists
if [[ -f "$TARGET" ]]; then
    rm -f "$TARGET"
    echo "Removed: $TARGET"
else
    echo "Binary not found at $TARGET"
fi

# Remove GIT_ASKPASS line from .bashrc
if grep -q "GIT_ASKPASS=.*$APP_NAME" "$HOME/.bashrc"; then
    sed -i.bak "/GIT_ASKPASS=.*$APP_NAME/d" "$HOME/.bashrc"
    echo "Removed GIT_ASKPASS from ~/.bashrc"
else
    echo "No GIT_ASKPASS line for $APP_NAME in ~/.bashrc"
fi

echo "Uninstallation complete. Run 'source ~/.bashrc' or restart your shell to apply changes."
