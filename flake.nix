{
  description = "System Configuration flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    strain = {
      url = "github:JacoMalan1/strain/0.1.4";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { nixpkgs-stable, home-manager, lanzaboote, agenix, ... }@inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        hotbox = nixpkgs-stable.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit system;
          };
          modules = [
            lanzaboote.nixosModules.lanzaboote
            ./hosts/hotbox
            agenix.nixosModules.default
          ];
        };
        django = nixpkgs-stable.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit system;
          };
          modules = [
            lanzaboote.nixosModules.lanzaboote
            ./hosts/django
            agenix.nixosModules.default
          ];
        };
        workhorse = nixpkgs-stable.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit system;
          };
          modules = [ lanzaboote.nixosModules.lanzaboote ./hosts/workhorse ];
        };
      };

      homeConfigurations = {
        "jacom@hotbox" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs;
            inherit system;
          };
          pkgs = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          modules =
            [ ./home/jacom/hotbox.nix inputs.nixvim.homeManagerModules.nixvim ];
        };
        "jacom@django" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs;
            inherit system;
          };
          pkgs = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [ 
	    ./home/jacom/django.nix 
	    inputs.nixvim.homeManagerModules.nixvim
            agenix.homeManagerModules.default
	  ];
        };
        "jacom@workhorse" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs;
            inherit system;
          };
          pkgs = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ./home/jacom/workhorse.nix
            inputs.nixvim.homeManagerModules.nixvim
          ];
        };
      };
    };
}
