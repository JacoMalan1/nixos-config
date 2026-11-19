{ pkgs, ... }:
{
  services.mongodb = {
    enable = true;
    package = pkgs.unstable.mongodb-ce;
  };
  environment.systemPackages = with pkgs.unstable; [ mongosh ];
}
