{ lib, ... }: {
  networking.nameservers = lib.mkDefault [ "194.242.2.2#dns.mullvad.net" ];
  services.resolved.fallbackDns = lib.mkDefault [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

  specialisation."cloudflare-dns".configuration = {
    networking.nameservers = [ "1.1.1.1#one.one.one.one" ];
    services.resolved.fallbackDns = [ "1.0.0.1#one.one.one.one" ];
  };
  
  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnsovertls = "true";
  };
  
}
