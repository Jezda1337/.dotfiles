{ pkgs, ... }:

{
  home.packages = [
    pkgs.lazygit
    pkgs.yazi

    pkgs.go
    pkgs.bun
    pkgs.pnpm
    pkgs.nodejs_22

    # pkgs.fnm # rust based node version manager

    # lsp
    pkgs.lua-language-server
    pkgs.typescript-language-server
    pkgs.vue-language-server
    pkgs.yaml-language-server
    pkgs.vim-language-server
    pkgs.tailwindcss-language-server
    pkgs.svelte-language-server
    pkgs.nginx-language-server
    pkgs.emmet-language-server
    pkgs.vscode-langservers-extracted
    pkgs.marksman
    pkgs.gopls
    pkgs.gotools
  ];
}
