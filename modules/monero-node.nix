{ inputs, system, config, ... }:
let pkgs = import inputs.nixpkgs-unstable { inherit system; };
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

  environment.systemPackages = with pkgs; [ monero-cli p2pool screen ];
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
      after =
        [ "network.target" "monerod.service" "systemd-modules-load.service" ];
      wants =
        [ "network.target" "monerod.service" "systemd-modules-load.service" ];
      script =
        "${pkgs.p2pool}/bin/p2pool --loglevel 2 --mini --wallet $(cat ${mining-address})";
      requires = [ "p2pool.socket" ];

      serviceConfig = {
        Type = "exec";
        Restart = "always";
        User = "p2pool";
        Group = "p2pool";

        TimeoutStop = 60;

        StandardInput = "socket";
        StandardOutput = "journal";
        StandardError = "journal";
        WorkingDirectory = "/var/lib/p2pool";

        Sockets = [ "p2pool.socket" ];
      };

      wantedBy = [ "multi-user.target" ];
    };

  systemd.sockets.p2pool = {
    description = "P2Pool Command Socket";
    socketConfig = {
      SocketUser = "p2pool";
      SocketGroup = "p2pool";
      ListenFIFO = "/run/p2pool/p2pool.control";
      RemoveOnStop = true;
      DirectoryMode = "0755";
      SocketMode = "0666";
    };
  };

  systemd.services.monerod =
    let conf-file = config.age.secrets.hotbox-monerod-conf.path;
    in {
      description = "Monero Daemon";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
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
