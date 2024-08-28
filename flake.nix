{
  description = "System Configuration flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = { 
      url = "github:nix-community/home-manager"; 
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixpkgs-mongodb-pin.url = "github:NixOS/nixpkgs/2527da1ef492c495d5391f3bcf9c1dd9f4514e32";
  };

  outputs = { self, nixpkgs-stable, home-manager, nixpkgs-mongodb-pin, ... }@inputs: {
    nixosConfigurations = {
      hotbox = nixpkgs-stable.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/hotbox
        ];
      };
      workhorse = nixpkgs-stable.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          ./hosts/workhorse
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
