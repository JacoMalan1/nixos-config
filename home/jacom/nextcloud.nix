{ inputs, lib, config, system, ... }: 
let 
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
in
{
  age.secrets.nextcloud-autosync-env = {
    file = ../../secrets/nextcloud-autosync-env.age;
  };

  systemd.user = {
    services.nextcloud-autosync = {
      Unit = {
        Description = "Auto sync Nextcloud";
        After = "network-online.target"; 
      };
      Service = {
        Type = "simple";
	EnvironmentFile = "/run/user/1000/agenix/nextcloud-autosync-env";
        ExecStart= "${pkgs.nextcloud-client}/bin/nextcloudcmd -h --non-interactive --path /GoldenCoast5e /home/jacom/NextCloud/GoldenCoast5e https://nc.codelog.co.za"; 
        TimeoutStopSec = "180";
        KillMode = "process";
        KillSignal = "SIGINT";
      };
      Install.WantedBy = ["multi-user.target"];
    };
    timers.nextcloud-autosync = {
      Unit.Description = "Automatic sync files with Nextcloud when booted up after 5 minutes then rerun every 60 minutes";
      Timer.OnBootSec = "5min";
      Timer.OnUnitActiveSec = "60min";
      Install.WantedBy = ["multi-user.target" "timers.target"];
    };
    startServices = true;
  };
}
