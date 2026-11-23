{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.unstable.linuxPackages_zen;
  boot.kernelModules = [ "amdgpu" ];
  hardware.cpu.x86.msr.enable = true;

  networking.hostName = "django";

  services.libinput.touchpad.naturalScrolling = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  services.seatd = {
    enable = true;
    user = "jacom";
  };

  services.udev.packages = [
    pkgs.unstable.gnome-settings-daemon
    pkgs.unstable.gcr_4
  ];

  security.polkit.enable = true;

  users.users.jacom.extraGroups = [ "kvm" ];

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs.unstable; [
    icu
    stdenv.cc.cc.lib
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  programs.netextender.enable = true;
}
