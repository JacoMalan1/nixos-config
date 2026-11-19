{ ... }:
{
  imports = [ ./packages.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    logRefusedPackets = true;
    logRefusedConnections = true;
    logReversePathDrops = true;
    checkReversePath = "loose";
  };

  services.resolved = {
    enable = true;
    settings.Resolve.Domains = [ "~." ];
  };

  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.usb-modeswitch.enable = true;
  hardware.ledger.enable = true;

  services.fwupd.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"
  '';

  users.groups.plugdev = { };
  users.users.jacom = {
    isNormalUser = true;
    description = "Jaco Malan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
    ];
  };

  programs.firefox.enable = true;
}
