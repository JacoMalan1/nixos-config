{ inputs, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
    overlays = [
      (final: prev: let
        pinned-pkgs = import inputs.nixpkgs-mongodb-pin {
          system = "x86_64-linux";
          config.allowUnfreePredicate = pkg: "mongodb" == (prev.lib.getName pkg);
        };
      in {
        mongodb-6_0 = pinned-pkgs.mongodb-6_0;
      })
    ];
  };
in
{
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-6_0;
  };
}
