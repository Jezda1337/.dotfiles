{ pkgs, ... }:

{
	home.packages = [
		pkgs.lazygit
		pkgs.yazi
		pkgs.tmux

		pkgs.go
		pkgs.bun
		pkgs.pnpm
		pkgs.nodejs_22

		# Formatters
		pkgs.alejandra # Nix
		pkgs.black # Python
		pkgs.prettierd # Multi-language
		pkgs.shfmt
		pkgs.isort
		pkgs.stylua

		# LSP
		pkgs.lua-language-server
		pkgs.nixd
		pkgs.cargo
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
		pkgs.nodePackages_latest.vls
		pkgs.nodePackages_latest.bash-language-server


		# Tools
		pkgs.git
		pkgs.cmake
		pkgs.fzf
		pkgs.gcc
		pkgs.gnumake
		pkgs.sqlite


		# pkgs.fnm # rust based node version manager

		pkgs.mangohud
		pkgs.protonup
		pkgs.lutris
		pkgs.heroic
		pkgs.bottles
		pkgs.wineWowPackages.waylandFull # wine for wayland
	];
}
