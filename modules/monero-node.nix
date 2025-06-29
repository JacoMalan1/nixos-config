{ inputs, system, config, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  # Prepare enough huge pages for all the nodes.
  boot.kernel.sysctl."vm.nr_hugepages" = 3072;
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

  networking.firewall.allowedTCPPorts = [ 18080 18081 18089 18084 ];

  # Enable Model-Specific Registers for XMRig
  hardware.cpu.x86.msr.enable = true;

  users = {
    users.monero = {
      isSystemUser = true;
      group = "monero";
    };
    groups.monero = { };

    users.p2pool = {
      isSystemUser = true;
      group = "p2pool";
    };
    groups.p2pool = { };
  };

  environment.systemPackages = with pkgs; [ monero-cli p2pool ];
  age.secrets = {
    hotbox-monerod-conf = {
      file = ../secrets/hotbox-monerod-conf.age;
      owner = "monero";
      group = "monero";
    };
    monero-mining-address = {
      file = ../secrets/monero-mining-address.age;
      owner = "p2pool";
      group = "p2pool";
    };
  };

  systemd.services.p2pool =
    let mining-address = config.age.secrets.monero-mining-address.path;
    in {
      description = "P2Pool Node";
      after = [ "network.target" ];
      script =
        "${pkgs.p2pool}/bin/p2pool --data-dir /home/p2pool --loglevel 1 --mini --wallet $(cat ${mining-address})";
      serviceConfig = {
        Restart = "always";
        User = "p2pool";
        Group = "p2pool";
        RuntimeDirectory = "p2pool";
      };
      wantedBy = [ "multi-user.target" ];
    };

  systemd.services.monerod =
    let conf-file = config.age.secrets.hotbox-monerod-conf.path;
    in {
      description = "Monero Daemon";
      after = [ "network-online.target" ];
      serviceConfig = {
        ExecStart =
          "${pkgs.monero-cli}/bin/monerod --config-file ${conf-file} --non-interactive";
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
