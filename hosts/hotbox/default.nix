{ ... }: {
  imports = [
    ./nixos/configuration.nix
    ./nixos/fs.nix
    ../common.nix
    ./nixos/programs.nix

    ../../modules/nvidia.nix
    ../../modules/steam.nix
    ../../modules/syncthing.nix
    ../../modules/yubikey.nix
    # ../../modules/dns.nix
    ../../modules/fonts.nix
    ../../modules/wifi.nix
    ../../modules/qemu.nix
    # ../../modules/mongodb.nix
    ../../modules/retro
    ../../modules/hyprland.nix
    ../../modules/obs.nix
    # ../../modules/jupyter.nix
    ../../modules/print.nix
    ../../modules/secureboot.nix
    ../../modules/docker.nix
    ../../modules/rstudio.nix
    ../../modules/ntpclient.nix
    ../../modules/mariadb.nix
    ../../modules/pritunl.nix
    ../../modules/postgres.nix
    ../../modules/monero-node.nix
    ../../modules/p2pool.nix
    ../../modules/netextender.nix
  ];
}
