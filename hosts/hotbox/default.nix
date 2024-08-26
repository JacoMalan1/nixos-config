{ ... }: {
  imports = [
    ./nixos/configuration.nix
    ./nixos/fs.nix
    ../common.nix
    ../../modules/nvidia.nix
    ../../modules/steam.nix
    ../../modules/syncthing.nix
  ];
}
