{ config, pkgs, lib, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.initrd.kernelModules = [ "amdgpu" ];

	services.xserver.enable = true;
	services.xserver.videoDrivers = [ "amdgpu" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
