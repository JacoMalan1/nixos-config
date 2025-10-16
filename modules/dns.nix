{ lib, ... }: {
  networking.nameservers = lib.mkDefault [ "1.1.1.1#one.one.one.one" ];
  networking.networkmanager.dns = "none";
  services.resolved.fallbackDns = lib.mkDefault [ "1.0.0.1#one.one.one.one" ];

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnsovertls = "true";
  };
}
