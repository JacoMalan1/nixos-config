{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_full;
      runAsRoot = false;
      swtpm.enable = true;
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "jacom" ];

  environment.systemPackages = with pkgs; [
    bridge-utils
    safe-rm
    dnsmasq
    spice-gtk
  ];
}
