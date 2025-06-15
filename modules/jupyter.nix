{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  environment.systemPackages = with pkgs; [
    python3
    python312Packages.ipython
    python312Packages.jupyter
  ];
}
