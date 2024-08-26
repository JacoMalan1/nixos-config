{
  description = "System Configuration flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = { 
      url = "github:nix-community/home-manager"; 
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs-stable, home-manager, ... }@inputs: {
    nixosConfigurations = {
      hotbox = nixpkgs-stable.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          ./hosts/hotbox
        ];
      };
    };

    homeConfigurations = {
      jacom = home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
        modules = [ ./home/jacom/home.nix ];
      };
    };
  };
}
