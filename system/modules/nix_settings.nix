{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-then 7d";
  };
}
