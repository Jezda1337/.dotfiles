{
	description = "NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		#nixpkgs.url = "github:nixos/nixpkgs/13fe00cb6c75461901f072ae62b5805baef9f8b2";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		#hyprland.url = "github:hyprwm/Hyprland";
		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
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
