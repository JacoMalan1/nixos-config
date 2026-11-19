{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    package = pkgs.unstable.postgresql_16;
  };
}
