{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable= true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls="exa --no-user --icons --sort=ext --long --header --git";
      ls-t="exa --icons --long --tree --level=2";
      tx="tmux new -s $1";
      viber="sh -c './Downloads/viber.AppImage'";
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles/.#system";
    };

    initExtra = ''
    '';
  };


  programs.kitty = {
    enable = true;
    font = {
      name = "MartianMono Nerd Font Mono";
      # name = "JetBrainsMono Nerd Font Mono";
      size = 11;
    };
    settings = {
      enable_audio_bell = false;
      background_opacity = "0.6";
      symbol_map = "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E62F,U+E700-U+E7C5,U+F000-U+F2E0,U+F300-U+F31C,U+F400-U+F4A9,U+F500-U+F8FF Symbols Nerd Font";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
}

