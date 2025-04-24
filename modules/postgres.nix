{ inputs, system, ... }: 
let
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
  };
}
