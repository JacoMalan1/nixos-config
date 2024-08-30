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
  ];
}
