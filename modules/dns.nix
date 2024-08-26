{ ... }: {
  networking.nameservers = [ "194.242.2.2#dns.mullvad.net" ];
  
  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };
}
