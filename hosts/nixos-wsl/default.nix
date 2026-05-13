{ ... }: {
  imports = [
    ./nixos/configuration.nix
    ../common.nix
    ../../modules/postgres.nix
  ];
}
