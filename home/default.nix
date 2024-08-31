{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "radoje";
  home.homeDirectory = "/home/radoje";

  imports = [
    ./shell
    ./programs
    ./packages
  ];

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.pointerCursor = {
    gtk.enable = true;
# x11.enable = true;
# package = pkgs.bibata-cursors;
# name = "Bibata-Modern-Classic";
# size = 16;

    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 24;
# x11 = {
#   enable = true;
#   defaultCursor = true;
# };
  };

# gtk = {
#   enable = true;

#   theme = {
#     package = pkgs.flat-remix-gtk;
#     name = "Flat-Remix-GTK-Grey-Darkest";
#   };

#   iconTheme = {
#     package = pkgs.adwaita-icon-theme;
#     name = "Adwaita";
#   };

#   font = {
#     name = "Sans";
#     size = 11;
#   };
# };

# Packages that should be installed to the user profile.


  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true; }; scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      ls = "exa --no-user --icons --sort=ext --long --header --git";
      ls-t = "exa --icons --long --tree --level=2";
      tx = "tmux new -s $1";
      viber = "sh -c './Downloads/viber.AppImage'";
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles/.#radoje";
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      # name = "MartianMono Nerd Font Mono";
      name = "JetBrainsMono Nerd Font Mono";
      size = 11;
    };
    settings = {
      enable_audio_bell = false;
      background_opacity = "0.6";
      symbol_map = "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E62F,U+E700-U+E7C5,U+F000-U+F2E0,U+F300-U+F31C,U+F400-U+F4A9,U+F500-U+F8FF Symbols Nerd Font";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
