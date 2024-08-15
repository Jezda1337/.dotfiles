{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		# helix.url = "github:helix-editor/helix/master";
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland = {
			url = "github:hyprwm/Hyprland";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};
		hyprcursor.url = "github:hyprwm/hyprcursor";
		nix-ld.url = "github:Mic92/nix-ld";
		# this line assume that you also have nixpkgs as an input
		nix-ld.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, nix-ld, ... }@inputs: {
		nixosConfigurations.system = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./system/configuration.nix
				home-manager.nixosModules.home-manager
				nix-ld.nixosModules.nix-ld
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					#home-manager.backupFileExtension = "backup";

					home-manager.users.radoje = import ./home;
				}
			];
		};
	};
}
