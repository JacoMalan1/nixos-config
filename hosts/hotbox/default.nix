{ ... }: {
  imports = [
    ./configuration.nix
    ../common.nix
    ../../modules/nvidia.nix
  ];
}
