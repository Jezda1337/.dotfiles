let
  userName = "Radoje";
  email = "megasrbin1@gmail.com";
in
{
  programs.git = {
    enable = true;
    userName = userName;
    userEmail = email;
  };

  programs.lazygit.enable = true;
  programs.lazygit.settings = {
    gui.border = "single";
  };
}
