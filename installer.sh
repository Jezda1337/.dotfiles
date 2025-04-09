#!/bin/bash

# npm i -g
declare -a lsps=(
  bash-language-server
  @angular/language-server
  @astrojs/language-server
  css-variables-language-server
  vscode-langservers-extracted
  cssmodules-language-server
  @tailwindcss/language-server
  typescript
  typescript-language-server
  @vue/language-server
)

# Check if npm is available
if ! command -v npm >/dev/null 2>&1; then
  echo "npm not found. Installing npm and nodejs via pacman..."
  sudo pacman -S npm nodejs --noconfirm
fi

export npm_config_prefix="$HOME/.local"
export PATH="$HOME/.local/bin:$PATH"

# Install LSPs globally
for lsp in "${lsps[@]}"; do
  npm install -g "$lsp"
done


# Install pacman-based LSPs
sudo pacman -S lua-language-server marksman --noconfirm

# Install Go-based LSPs
go install golang.org/x/tools/gopls@latest
go install github.com/a-h/templ/cmd/templ@latest

# Install programming languages using pacman
sudo pacman -S go
