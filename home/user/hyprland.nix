{inputs, pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    # plugins = [
    #   inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    # ];
  };
}
