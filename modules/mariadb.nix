{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  environment.systemPackages = with pkgs; [ mariadb.client ];
}
