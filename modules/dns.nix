{ lib, ... }: {
  networking.nameservers = lib.mkForce [ "1.1.1.1#one.one.one.one" ];
  networking.networkmanager.dns = lib.mkForce "none";

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnssec = "true";
    fallbackDns = lib.mkForce [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };
}
