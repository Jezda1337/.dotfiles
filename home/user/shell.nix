{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable= true;
    syntaxHighlighting.enable = true;
  };


  programs.kitty = {
    enable = true;
    font = {
      name = "MartianMono Nerd Font Mono";
      size = 11;
    };
    settings = {
      enable_audio_bell = false;
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

