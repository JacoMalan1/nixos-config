{ inputs, ... }:
let
  pkgs = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
in
{
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
  };
  environment.systemPackages = with pkgs; [
    mongosh
  ];
}
