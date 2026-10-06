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
        # 18089 (restricted RPC) intentionally excluded - do not expose RPC over Tor.
        map = [ { port = 18084; } { port = 18080; } ];
      };
    };
  };

  # 18081 (unrestricted daemon RPC) intentionally excluded - must stay localhost-only.
  networking.firewall.allowedTCPPorts = [ 18080 18089 18084 3333 ];

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
    let 
      conf-file = config.age.secrets.hotbox-monerod-conf.path;
      node-ban-list = pkgs.fetchurl {
	url = "https://raw.githubusercontent.com/Boog900/monero-ban-list/refs/heads/main/ban_list.txt";
	hash = "sha256-xsu85NX3ogizaZBfv1LsFsiJuBSAYaYakI38K3iJwu4=";
      };
    in {
      description = "Monero Daemon";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        ExecStart =
          "${pkgs.monero-cli}/bin/monerod --config-file ${conf-file} --add-priority-node=p2pmd.xmrvsbeast.com:18080 --non-interactive --ban-list ${node-ban-list}";
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

        # Hardening. ProtectSystem=full (not strict) since the exact set of
        # paths monerod touches outside its datadir isn't known here - full
        # still locks down /usr, /etc, /boot without risking the datadir.
        # ProtectHome=read-only + ReadWritePaths punches a hole just for the
        # real data dir (confirmed from the daemon's own "permission denied
        # /home/monero/.monerod" error after ProtectHome=true blocked it
        # outright) while still blocking writes everywhere else under /home.
        # MemoryDenyWriteExecute is deliberately omitted: monerod's RandomX
        # block verification can need a JIT, which W^X would break.
        NoNewPrivileges = true;
        ProtectSystem = "full";
        ProtectHome = "read-only";
        ReadWritePaths = [ "/home/monero/.monerod" ];
        PrivateTmp = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectClock = true;
        RestrictSUIDSGID = true;
        RestrictRealtime = true;
        RestrictNamespaces = true;
        LockPersonality = true;
        CapabilityBoundingSet = [ ];
      };
      wantedBy = [ "multi-user.target" ];
    };
}
