{ nixpkgs-unstable, ... }:
  let
    pkgs = import nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
  in
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_full;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };

  users.users.jacom.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    bridge-utils
    safe-rm
    dnsmasq
  ];
}
