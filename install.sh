#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FZSYS_SRC="$SCRIPT_DIR/fzsys.sh"
BIN_DST="/usr/local/bin/fzsys"

echo "Installing fzsys to $BIN_DST (requires sudo)..."
sudo install -m 755 "$FZSYS_SRC" "$BIN_DST"
echo "fzsys installed."

if ! command -v fzf >/dev/null 2>&1; then
  echo "WARNING: fzf is not installed. Please install fzf to use fzsys."
else
  echo "fzf is installed."
fi

echo "Installation complete! Run 'fzsys' from your terminal."