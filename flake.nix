{
  description = "System Configuration flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = { 
      url = "github:nix-community/home-manager/release-24.05"; 
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixpkgs-mongodb-pin.url = "github:NixOS/nixpkgs/2527da1ef492c495d5391f3bcf9c1dd9f4514e32";
    strain = {
      url = "github:JacoMalan1/strain";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { nixpkgs-stable, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      hotbox = nixpkgs-stable.lib.nixosSystem {
        specialArgs = { inherit inputs; inherit system; };
        modules = [
          ./hosts/hotbox
        ];
      };
      workhorse = nixpkgs-stable.lib.nixosSystem {
        specialArgs = { inherit inputs; inherit system; };
        modules = [
          ./hosts/workhorse
        ];
      };
    };

    homeConfigurations = {
      hotbox-jacom = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; inherit system; };
        pkgs = import inputs.nixpkgs-stable { inherit system; config.allowUnfree = true; };
        modules = [ ./home/jacom/hotbox.nix ];
      };
      workhorse-jacom = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; inherit system; };
        pkgs = import inputs.nixpkgs-stable { inherit system; config.allowUnfree = true; };
        modules = [ ./home/jacom/workhorse.nix ];
      };
    };
  };
}
