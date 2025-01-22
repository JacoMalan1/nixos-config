{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in { environment.systemPackages = with pkgs; [ go ]; }
