{ ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./fs.nix
    ./gpu.nix
    ./packages.nix
    ../common.nix
    ../../modules/desktop
    ../../modules/hardware/amd-cpu.nix

    ../../modules/apps/steam.nix
    ../../modules/services/syncthing.nix
    ../../modules/hardware/yubikey.nix
    ../../modules/desktop/fonts.nix
    ../../modules/services/wifi.nix
    ../../modules/services/qemu.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/hardware/print.nix
    ../../modules/hardware/secureboot.nix
    ../../modules/services/docker.nix
    ../../modules/services/ntpclient.nix
    ../../modules/services/monero-node.nix
    ../../modules/services/netextender.nix
    ../../modules/services/protonmail.nix
    ../../modules/hardware/amdgpu.nix
    ../../modules/hardware/tpm.nix
    ../../modules/apps/wireshark.nix
    ../../modules/desktop/flatpak.nix
    ../../modules/apps/java.nix
  ];
}
