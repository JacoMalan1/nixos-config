{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  virtualisation.libvirtd = {
    allowedBridges = [ "virbr0" "virbr1" "virbr2" "vnet2" "vnet3" "vnet6" ];
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

  virtualisation.spiceUSBRedirection.enable = true;

  users.users.jacom.extraGroups = [ "libvirtd" ];

  networking.firewall.trustedInterfaces =
    [ "virbr1" "virbr2" "vnet2" "vnet3" "vnet6" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    bridge-utils
    safe-rm
    dnsmasq
    spice-gtk
  ];
}
