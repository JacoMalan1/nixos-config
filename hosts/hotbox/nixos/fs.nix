{ ... }: {
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BF4C-180D";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  boot.initrd.luks.fido2Support = false;
  boot.initrd.luks.devices = {
    "luks-ba3cf3e3-a001-4e13-9740-8116f72bc66c" = {
      device = "/dev/disk/by-uuid/ba3cf3e3-a001-4e13-9740-8116f72bc66c";
      crypttabExtraOpts = [ "fido2-device=auto" ];
    };
    "cryptstore" = {
      device = "/dev/disk/by-uuid/d64c7fc9-c1b4-42ee-8bd8-73df1473e28e";
      keyFile = "/root/keyfile";
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bdd1a1f1-a1f4-4067-aab8-e7eff3d5b027";
    fsType = "ext4";
  };
  fileSystems."/nix" = {
    device = "/dev/disk/by-label/nix";
    fsType = "ext4";
  };
  fileSystems."/home".device = "/dev/mapper/crypthome";
  fileSystems."/mnt/bulk".device = "/dev/mapper/crypthdd";

  environment.etc.crypttab.text = ''
    crypthome UUID=7b8ccd1d-d947-4378-bc49-e6cb397e4261 /root/keyfile
    crypthdd UUID=a57428e5-3717-4b8b-8ea3-c05090942a7d /root/keyfile
  '';
}
