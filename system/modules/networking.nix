{ ... }:
{
  # networking.hostName = "nixos"; Define your hostname.
  # networking.wireless.enable = true; Enable wireless support via wpa_supplicant.
  networking.networkingmanager.enable = true;

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
