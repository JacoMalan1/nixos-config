{ ... }: {
  boot.initrd.luks.fido2Support = false;
  fileSystems."/home".device = "/dev/mapper/crypthome";

  environment.etc.crypttab.text = ''
    crypthome UUID=bdfc4478-2c1e-4562-81ed-188060f346e4 /root/keyfile
    cryptswap UUID=a0f40cf6-d932-48b8-8317-fe3b77ca9408 /root/keyfile
  '';
}
