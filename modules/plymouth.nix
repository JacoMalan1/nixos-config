{ ... }: {
  boot.plymouth.enable = true;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
  ];
}
