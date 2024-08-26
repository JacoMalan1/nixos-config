{
  description = "System Configuration flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      hotbox = nixpkgs.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          ./hosts/hotbox
        ];
      };
    };
  };
}
