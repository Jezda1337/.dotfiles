{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Radoje";
    userEmail = "megasrbin1@gmail.com";
  };

  programs.lazygit.enable = true;
  programs.lazygit.settings = {
    gui.border = "single";
  };
}
