{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";   
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = inputs@{ nixpkgs, hyprland, home-manager, yazi, ... }: {
    nixosConfigurations = {
      radoje = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; inherit hyprland; };
        modules = [
          ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.radoje = import ./home/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; inherit hyprland; };
            }
        ];
      };
    };
  };
}
