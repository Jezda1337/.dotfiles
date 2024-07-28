{inputs, pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    plugins = [
      # inputs.hyprland-plugins.packages."x86_64-linux".hyprbars
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
    ];
  };
}
