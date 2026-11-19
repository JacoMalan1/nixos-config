{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs.stable; [
    skopeo
    slirp4netns
    passt
  ];

  systemd.user.services.docker = {
    enable = true;
    environment = {
      DOCKERD_ROOTLESS_ROOTLESSKIT_NET = "pasta";
    };
  };

  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };
      rootless = {
        enable = true;
        extraPackages = with pkgs.stable; [ passt ];
        setSocketVariable = true;
      };
    };
  };
}
