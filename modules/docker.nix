{ inputs, lib, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  environment.systemPackages = with pkgs; [ skopeo slirp4netns passt ];
  networking.firewall.enable = lib.mkForce false;

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
	dns = [ "1.1.1.1" "8.8.8.8" ];
      };
      rootless = {
	enable = true;
	extraPackages = with pkgs; [ passt ];
	setSocketVariable = true;
      };
    };
  };
}
