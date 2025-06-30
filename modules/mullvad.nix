{ config, inputs, system, ... }: {
  age.secrets.mullvad-private-key = {
    file = ../secrets/mullvad-private-key.age;
    mode = "0600";
  };

  networking.wg-quick.interfaces = {
    za-jnb-001 = {
      autostart = false;
      address = [ "10.71.61.108/32" "fc00:bbbb:bbbb:bb01::8:3d6b/128" ];
      dns = [ "10.64.0.1" ];
      privateKeyFile = config.age.secrets.mullvad-private-key.path;

      peers = [{
        publicKey = "5dOGXJ9JK/Bul0q57jsuvjNnc15gRpSO1rMbxkf4J2M=";
        allowedIPs = [ "0.0.0.0/0" "::0/0" ];
        endpoint = "154.47.30.130:51820";
      }];
    };
  };
}
