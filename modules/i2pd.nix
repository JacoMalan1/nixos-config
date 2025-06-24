{ ... }: {
  services.i2pd = {
    enable = true;
    proto.http.enable = true;
    proto.httpProxy.enable = true;
    proto.httpProxy.outproxy = "http://exit.stormycloud.i2p";
    bandwidth = 128;
  };
}
