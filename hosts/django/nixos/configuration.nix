# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./fs.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
  boot.kernelModules = [ "zenpower" "amdgpu" ];
  hardware.cpu.x86.msr.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "django"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  environment.sessionVariables = { FLAKE = "$HOME/nix"; };

  # Enable the X11 windowing system.
  services.libinput.touchpad.naturalScrolling = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  services.resolved = {
    enable = true;
    domains = [ "~." ];
  };

  # Enable the GNOME Desktop Environment.
  services.seatd = {
    enable = true;
    user = "jacom";
  };

  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"
    '';
    packages = [ pkgs.gnome-settings-daemon pkgs.gcr ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.blueman.enable = true;
  services.fwupd.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.usb-modeswitch.enable = true;
  hardware.ledger.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  security.rtkit.enable = true;
  security.polkit = { enable = true; };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.plugdev = { };
  users.users.jacom = {
    isNormalUser = true;
    description = "Jaco Malan";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ icu ];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.xserver = { desktopManager.gnome.enable = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
    allowedTCPPorts = [ 22 22000 ];
    allowedUDPPorts = [ 22000 ];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  services.postgresql.settings.port = lib.mkForce 5433;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = true;
    };
  };
}
