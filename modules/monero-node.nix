{ ... }: {
  services.tor = {
    enable = true;
    enableGeoIP = false;
    relay.onionServices = {
      monero = {
        version = 3;
        map = [{ port = 18089; }];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 18089 18081 ];

  services.monero = {
    enable = true;
    dataDir = "/home/monero/.monerod";
    extraConfig = ''
      prune-blockchain=1
      sync-pruned-blocks=1
      rpc-restricted-bind-ip=0.0.0.0
      rpc-restricted-bind-port=18089
      rpc-ssl=autodetect
    '';
  };
}
