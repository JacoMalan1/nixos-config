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
    ../../modules/dns.nix
    ../../modules/fonts.nix
    ../../modules/wifi.nix
    ../../modules/leftwm.nix
    ../../modules/qemu.nix
    ../../modules/mongodb.nix
    ../../modules/retro
    ../../modules/hyprland.nix
  ];
}
