{ ... }: {
  imports = [
    ./nixos/configuration.nix
    ../common.nix
    ../../modules/docker.nix
  ];
}
