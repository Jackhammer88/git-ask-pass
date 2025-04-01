#!/bin/bash
set -euo pipefail

APP_NAME="git-ask-pass"
INSTALL_PATH="${XDG_BIN_HOME:-$HOME/.local/bin}"
TARGET="$INSTALL_PATH/$APP_NAME"

echo "Installing $APP_NAME..."

# Check if binary exists
if [[ ! -f "./$APP_NAME" ]]; then
    echo "Error: ./$APP_NAME not found. Please build it first."
    exit 1
fi

# Ensure installation directory exists
mkdir -p "$INSTALL_PATH"

# Copy binary
cp -f "./$APP_NAME" "$TARGET"
chmod +x "$TARGET"

# Add GIT_ASKPASS to .bashrc if not already present
if ! grep -q "GIT_ASKPASS=" "$HOME/.bashrc"; then
    echo "Adding GIT_ASKPASS to ~/.bashrc"
    echo "export GIT_ASKPASS=\"$TARGET\"" >> "$HOME/.bashrc"
else
    echo "GIT_ASKPASS is already set in ~/.bashrc"
fi

# Check if path is in $PATH
if ! echo "$PATH" | grep -q "$INSTALL_PATH"; then
    echo "Warning: $INSTALL_PATH is not in your PATH"
    echo "You may need to add the following line to your ~/.bashrc:"
    echo "export PATH=\"\$PATH:$INSTALL_PATH\""
fi

echo "Installed to $TARGET"
echo "Run 'source ~/.bashrc' or restart your shell to apply changes."
