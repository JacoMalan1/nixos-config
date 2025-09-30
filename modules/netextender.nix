{ lib, config, inputs, ... }:
let
  cfg = config.programs.netextender;
  system = "x86_64-linux";
  netextender = inputs.netextender.packages.${system}.default;
in {
  options = {
    programs.netextender = {
      enable = lib.mkEnableOption "SonicWall NetExtender service";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ netextender ];

    systemd.services.netextender = {
      description = "SonicWall NetExtender service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Restart = "on-failure";
        ExecStart = "${netextender}/bin/NEService";
        KillMode = "process";
      };
    };
  };
}
