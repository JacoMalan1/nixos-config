{ ... }: {
  imports = [
    ./nixos/configuration.nix
    ../common.nix
    ../../modules/dns.nix
    ../../modules/yubikey.nix
    ../../modules/wifi.nix
    ../../modules/syncthing.nix
    ../../modules/fonts.nix
  ];
}
