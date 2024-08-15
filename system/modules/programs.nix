{ config, pkgs, ... }:
{
  programs.dconf.enable = true;

	#444444programs.nix-ld.enable = true;

  programs.zsh = {
    enable = true;
  };
  programs.mtr = {
    enable = true;
  };
}
