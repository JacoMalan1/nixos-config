{ inputs, system, config, ... }:
let pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  # Prepare enough huge pages for all the nodes.
  boot.kernel.sysctl."vm.nr_hugepages" = 3072;
  services.tor = {
    enable = true;
    client.enable = true;
    enableGeoIP = false;
    settings.ControlPort = [ { port = 9051; } ];
    relay.onionServices = {
      monero = {
        version = 3;
        map = [ { port = 18089; } { port = 18084; } { port = 18080; } ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 18080 18081 18089 18084 3333 ];

  # Enable Model-Specific Registers for XMRig
  hardware.cpu.x86.msr.enable = true;

  users = {
    users.monero = {
      isSystemUser = true;
      group = "monero";
    };
    groups.monero = { };
  };

  environment.systemPackages = with pkgs; [ monero-cli p2pool screen ];
  age.secrets = {
    hotbox-monerod-conf = {
      file = ../secrets/hotbox-monerod-conf.age;
      owner = "monero";
      group = "monero";
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
          "${pkgs.monero-cli}/bin/monerod --config-file ${conf-file} --add-priority-node=nodes.hashvault.pro:18080 --add-priority-node=p2pmd.xmrvsbeast.com:18080 --non-interactive";
        ExecStartPost = "/run/current-system/sw/bin/sleep 0.1";
	Environment = [ "DNS_PUBLIC=tcp://1.1.1.1" ];

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
