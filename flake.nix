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
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    netextender = {
      url = "github:JacoMalan1/nixos-netextender";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    spotify = {
      url = "/home/jacom/Code/Nix/spotify";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, home-manager, lanzaboote, agenix, ... }@inputs:
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
	nixos-wsl = nixpkgs-unstable.lib.nixosSystem { # WSL Configuration
	  inherit system;
	  specialArgs = {
	    inherit inputs;
	    inherit system;
	  };

	  modules = [
	    inputs.nixos-wsl.nixosModules.default
	    inputs.home-manager.nixosModules.home-manager
	    ./hosts/nixos-wsl
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.extraSpecialArgs = { inherit inputs; inherit system; };
	      home-manager.users.jacom = { ... }: {
		imports = [ 
		  inputs.nixvim.homeModules.nixvim
		  ./home/jacom/nixos-wsl.nix 
		];
	      };
	    }
	  ];
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
            [ ./home/jacom/hotbox.nix inputs.nixvim.homeModules.nixvim ];
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
	    inputs.nixvim.homeModules.nixvim
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
            inputs.nixvim.homeModules.nixvim
          ];
        };
      };
    };
}
