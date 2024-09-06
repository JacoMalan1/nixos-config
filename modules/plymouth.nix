{ ... }: {
  boot.plymouth.enable = true;
  boot.kernelParams = [
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
  ];
}
