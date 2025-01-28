{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  virtualisation.libvirtd = {
    allowedBridges = [ "virbr0" "virbr1" "virbr2" ];
    enable = true;
    qemu = {
      package = pkgs.qemu_full;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  users.users.jacom.extraGroups = [ "libvirtd" ];

  networking.firewall.interfaces.virbr2 = {
    allowedTCPPortRanges = [{
      from = 0;
      to = 65535;
    }];
    allowedUDPPortRanges = [{
      from = 0;
      to = 65535;
    }];
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    bridge-utils
    safe-rm
    dnsmasq
  ];
}
