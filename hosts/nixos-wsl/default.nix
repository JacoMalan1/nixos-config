{ ... }: {
  imports = [
    ./configuration.nix
    ../common.nix
    ../../modules/services/docker.nix
  ];
}
