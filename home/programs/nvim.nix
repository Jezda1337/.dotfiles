{ ... }:
{
  home.file.".config/nvim".source = ../config/nvim;
  programs.neovim = {
    enable = true;
    # extraLuaConfig = ''
    #   ${builtins.readFile ../config/nvim/}
    # '';
  };
}
