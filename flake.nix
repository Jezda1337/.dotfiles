{
	description = "NixOS configuration";

	inputs = {
		#nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs.url = "github:nixos/nixpkgs/b79ce4c43f9117b2912e7dbc68ccae4539259dda";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		hyprland.url = "github:hyprwm/Hyprland";
		yazi.url = "github:sxyazi/yazi";
		stylix.url = "github:danth/stylix";
	};

	outputs = inputs@{ nixpkgs, home-manager, stylix, ... }: {
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					./nixos/configuration.nix

					stylix.nixosModules.stylix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.radoje = import ./home/home.nix;
						home-manager.extraSpecialArgs = { inherit inputs; };
					}
				];
			};
		};
	};
}
