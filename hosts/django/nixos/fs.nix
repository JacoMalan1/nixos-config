{ ... }: {
  boot.initrd.luks.fido2Support = false;
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4c5be6b8-dfc0-48fd-8f12-05808a026091";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-c00baea7-2ca8-4242-bcae-350c7c431c9c" = {
    device = "/dev/disk/by-uuid/c00baea7-2ca8-4242-bcae-350c7c431c9c";
    crypttabExtraOpts = [ "fido2-device=auto" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DA77-7C6F";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/crypthome";
    fsType = "ext4";
  };

  environment.etc.crypttab.text = ''
    crypthome UUID=9b83eac0-d9ae-460a-b175-b065bb529a03 /root/keyfile
  '';
}
