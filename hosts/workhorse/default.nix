{ ... }: {
  imports = [
    ./nixos/configuration.nix
    ./nixos/programs.nix
    ../common.nix

    ../../modules/dns.nix
    ../../modules/yubikey.nix
    ../../modules/wifi.nix
    ../../modules/syncthing.nix
    ../../modules/fonts.nix
    ../../modules/leftwm.nix
    ../../modules/hyprland.nix
    ../../modules/golang.nix
    # ../../modules/mongodb.nix
    ../../modules/print.nix
    ../../modules/docker.nix
    ../../modules/secureboot.nix
    ../../modules/mariadb.nix
  ];
}
