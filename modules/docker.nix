{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  environment.systemPackages = with pkgs; [ skopeo ];

  virtualisation = {
    containers.enable = true;
    docker.enable = true;
  };
}
