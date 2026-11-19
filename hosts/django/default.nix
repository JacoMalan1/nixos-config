{ ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./fs.nix
    ./packages.nix
    ../common.nix
    ../../modules/desktop
    ../../modules/hardware/amd-cpu.nix
    ../../modules/hardware/amdgpu.nix

    ../../modules/hardware/yubikey.nix
    ../../modules/services/wifi.nix
    ../../modules/services/syncthing.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/apps/golang.nix
    ../../modules/services/mongodb.nix
    ../../modules/hardware/print.nix
    ../../modules/services/docker.nix
    ../../modules/services/mariadb.nix
    ../../modules/services/pritunl.nix
    ../../modules/apps/wireshark.nix
    ../../modules/apps/java.nix
    ../../modules/hardware/secureboot.nix
    ../../modules/services/postgres.nix
    ../../modules/desktop/flatpak.nix
    ../../modules/services/qemu.nix
    ../../modules/services/mullvad.nix
    ../../modules/services/protonmail.nix
    ../../modules/services/netextender.nix
  ];
}
