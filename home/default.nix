{ ... }:

{
  imports = [
    ./user
  ];
  
  home.username = "radoje";
  home.homeDirectory = "/home/radoje";
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
