{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
			eval "$(fzf --bash)"
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
			export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
    '';
    shellAliases = {
      ls = "exa --no-user --icons --sort=ext --long --header --git";
      ls-t = "exa --icons --long --tree --level=2";
      tx = "tmux new -s $1";
      viber = "sh -c './Downloads/viber.AppImage'";
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
    };
  };
}
