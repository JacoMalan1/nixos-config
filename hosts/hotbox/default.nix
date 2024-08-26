{ ... }: {
  imports = [
    ./nixos/configuration.nix
    ./nixos/fs.nix
    ../common.nix
    ../../modules/nvidia.nix
    ../../modules/steam.nix
    ../../modules/syncthing.nix
    ../../modules/yubikey.nix
    ../../modules/dns.nix
    ../../modules/fonts.nix
    ../../modules/wifi.nix
  ];
}
