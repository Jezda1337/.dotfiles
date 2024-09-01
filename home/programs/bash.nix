{ ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
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
