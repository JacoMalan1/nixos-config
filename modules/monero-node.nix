{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  services.tor = {
    enable = true;
    client.enable = true;
    enableGeoIP = false;
    relay.onionServices = {
      monero = {
        version = 3;
        map = [ { port = 18089; } { port = 18084; } ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 18081 18089 18084 ];

  users = {
    users.monero = {
      isSystemUser = true;
      group = "monero";
    };
    groups.monero = { };
  };

  environment.systemPackages = with pkgs; [ monero-cli ];
  systemd.services.monerod = {
    description = "Monero Daemon";
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart =
        "${pkgs.monero-cli}/bin/monerod --config-file /etc/monero/monerod.conf --non-interactive";
      ExecStartPost = "/run/current-system/sw/bin/sleep 0.1";

      Restart = "always";
      RestartSec = 30;
      SuccessExitStatus = [ 0 1 ];

      User = "monero";
      Group = "monero";
      RuntimeDirectory = "monero";

      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
