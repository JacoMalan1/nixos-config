{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
in
{
  environment.systemPackages = with pkgs; [
    python3
    python311Packages.ipython
    python311Packages.jupyter
  ];
}
