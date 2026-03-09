#!/bin/bash
# curl -fsSL https://raw.githubusercontent.com/sys-ax/tmux-setup-installme/main/install.sh | bash
set -euo pipefail

echo "tmux-setup installer"
echo ""

# gh required
if ! command -v gh &>/dev/null; then
  echo "Install GitHub CLI first: https://cli.github.com"
  exit 1
fi

# auth required
if ! gh auth status &>/dev/null; then
  echo "Run: gh auth login"
  exit 1
fi

# clone + run
T=$(mktemp -d)
trap "rm -rf '$T'" EXIT
gh repo clone sys-ax/tmux-setup "$T/tmux-setup" -- --depth 1 2>/dev/null || { echo "No access to sys-ax/tmux-setup"; exit 1; }
exec bash "$T/tmux-setup/install.sh"
