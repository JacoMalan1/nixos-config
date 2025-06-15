{ ... }: {
  imports = [
    ./nixos/configuration.nix
    ./nixos/programs.nix
    ../common.nix

    ../../modules/yubikey.nix
    ../../modules/wifi.nix
    ../../modules/syncthing.nix
    ../../modules/fonts.nix
    ../../modules/hyprland.nix
    ../../modules/golang.nix
    ../../modules/mongodb.nix
    ../../modules/print.nix
    ../../modules/docker.nix
    ../../modules/mariadb.nix
    ../../modules/pritunl.nix
    ../../modules/wireshark.nix
    ../../modules/jdk17.nix
    ../../modules/secureboot.nix
    ../../modules/postgres.nix
    # ../../modules/rstudio.nix
    ../../modules/flatpak.nix
    ../../modules/qemu.nix
    ../../modules/jupyter.nix
  ];
}
