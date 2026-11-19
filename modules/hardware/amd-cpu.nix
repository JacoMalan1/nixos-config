{ config, ... }:
{
  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
  boot.kernelModules = [ "zenpower" ];
}
