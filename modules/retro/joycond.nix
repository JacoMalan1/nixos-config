{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
in
{
  services.joycond =  {
    enable = true;
    package = pkgs.joycond;
  };
}
