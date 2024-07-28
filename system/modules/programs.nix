{ config, pkgs, ... }:
{
  programs.dconf.enable = true;

	programs.nix-ld.enable = true;

  programs.zsh = {
    enable = true;
  };
  programs.mtr = {
    enable = true;
  };
}
