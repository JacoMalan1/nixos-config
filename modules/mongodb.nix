{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
  };
  environment.systemPackages = with pkgs; [ mongosh ];
}
