{
  description = "System Configuration flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = { 
      url = "github:nix-community/home-manager/release-24.11"; 
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs-stable, home-manager, lanzaboote, ... }@inputs: 
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      hotbox = nixpkgs-stable.lib.nixosSystem {
        specialArgs = { inherit inputs; inherit system; };
        modules = [
            lanzaboote.nixosModules.lanzaboote
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
