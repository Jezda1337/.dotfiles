{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    firefox
    kitty
    lazygit
    gh
    pamixer # control sound much easier
  ];
}
