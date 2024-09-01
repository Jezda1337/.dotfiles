{ pkgs, lib, config, ...}:

{
  imports = [
    ./programs
  ];

  home = {
    username = "radoje";
    homeDirectory = "/home/radoje";
    stateVersion = "24.05";
    packages = (with pkgs; [
      neofetch

      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep
      jq
      yq-go
      eza
      fzf

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      dnsutils  # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      aria2 # A lightweight multi-protocol & multi-source command-line download utility
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc  # it is a calculator for the IPv4/v6 addresses

      # misc
      file
      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg

      # nix related
      #
      # it provides the command `nom` works just like `nix`
      # with more details log output
      nix-output-monitor

      # productivity
      glow # markdown previewer in terminal

      btop  # replacement of htop/nmon
      iotop # io monitoring
      iftop # network monitoring

      # system call monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      lsof # list open files

      # system tools
      sysstat
      lm_sensors # for `sensors` command
      ethtool
      pciutils # lspci
      usbutils # lsusb
    ]);

    pointerCursor = {
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
  };

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
