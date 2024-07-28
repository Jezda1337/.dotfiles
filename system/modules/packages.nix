{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    btop
    eza
    fzf
    git
    gnumake
    lm_sensors
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    neofetch
    vim
    ripgrep
    tldr
    unzip
    openssl
    openssl.dev
    pkg-config
    wget
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-wlr
    zip
    zoxide
    neofetch
    cliphist
    wf-recorder
    grim
    wl-clipboard
    jq
    sxiv
    swww

  ];
}
