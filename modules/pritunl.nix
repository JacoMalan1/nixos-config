{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  environment.systemPackages = with pkgs; [ pritunl-client ];
  systemd.services.pritunl-client-service = {
    enable = true;
    after = [ "network.target" ];
    description = "Pritunl client service.";
    script = "${pkgs.pritunl-client}/bin/pritunl-client-service";
    wantedBy = [ "multi-user.target" ];
  };
}
