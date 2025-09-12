{ config, inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  imports = [ ./hardware-configuration.nix ];

  custom.commonConfiguration.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  boot.blacklistedKernelModules = [ "k10temp" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];

  boot.kernelModules = [ "zenpower" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "hotbox"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  networking.wireguard.enable = true;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.usb-modeswitch.enable = true;
  hardware.ledger.enable = true;

  services.acpid.enable = true;

  services.libinput = {
    enable = true;
    mouse = { accelProfile = "flat"; };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  services.gnome.gnome-keyring.enable = true;

  services.fwupd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.unprivilegedUsernsClone = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.groups.plugdev = { };

  users.users.jacom = {
    isNormalUser = true;
    description = "Jaco Malan";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "plugdev" ];
    packages = with pkgs; [ kitty zellij ];
  };

  programs.firefox.enable = true;

  # NixOS Dynamically linked binaries fix
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libspatialite
    libxml2
    freetype
    icu
    nss
  ];

  # specialisation.gnome.configuration = {
  #   services.xserver = {
  #     enable = true;
  #     displayManager.gdm.enable = true;
  #     desktopManager.gnome.enable = true;
  #   };
  # };

  programs.ssh.startAgent = false;

  programs.wireshark.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = true;
    };
  };

  networking.firewall.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"
  '';

  # Open ports in the firewall.
  networking.firewall = {
    logRefusedPackets = true;
    logRefusedConnections = true;
    logReversePathDrops = true;
    checkReversePath = "loose";
    allowedTCPPorts = [ 8384 22000 25565 22 27017 18089 18081 18084 4200 18189 18141 ];
    allowedUDPPorts = [ 22000 21027 27017 51821 18189 18141 ];
  };

  # Do not remove
  system.stateVersion = "24.05";

  services.tor = {
    enable = pkgs.lib.mkForce true;
    client.enable = pkgs.lib.mkForce true;
  };

  services.resolved.enable = true;
  services.flatpak.enable = true;

  age.secrets.monero-mining-address = {
    file = ../../../secrets/monero-mining-address.age;
    owner = "p2pool";
    group = "p2pool";
  };

  services.p2pool = {
    enable = true;
    walletAddress = "$WALLET_ADDRESS";
    environmentFile = config.age.secrets.monero-mining-address.path;
    sidechain = "mini";
    mergeMining = {
      enable = true;
      walletAddress = "$TARI_WALLET_ADDRESS";
      nodeAddress = "tari://127.0.0.1:18102";
    };
  };
}
