{
  description = "System Configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations = {
      hotbox = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/hotbox
        ];
      };
    };
  };
}
