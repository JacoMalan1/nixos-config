{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [ pritunl-client ];
  systemd.services.pritunl-client-service = {
    enable = true;
    after = [ "network.target" ];
    description = "Pritunl client service.";
    script = "${pkgs.unstable.pritunl-client}/bin/pritunl-client-service";
    wantedBy = [ "multi-user.target" ];
  };
}
