{ ... }: {
  imports = [
    ./configuration.nix
    ../../modules/nvidia.nix
  ];
}
