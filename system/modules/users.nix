{ config, pkgs, ... }:

{
users.users.radoje = {
     isNormalUser = true;
     shell = pkgs.zsh;
     extraGroups = [ 
     	"wheel"  # root
        "qemu"
        "kvm"
        "libvirtd"
        "networkmanager"
     ]; 
   };
}
