{ lib, ... }: {
  networking.nameservers = lib.mkForce [ "194.242.2.2#dns.mullvad.net" ];
  networking.networkmanager.dns = lib.mkForce "systemd-resolved";

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnssec = "true";
    fallbackDns = lib.mkForce [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };
}
