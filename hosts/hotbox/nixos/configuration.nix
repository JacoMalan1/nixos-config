# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, inputs, system, ... }: 
let 
  pkgs = import inputs.nixpkgs-stable { inherit system; config.allowUnfree = true; };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  
  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_hardened;
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];

  boot.kernelModules = [ "zenpower" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "hotbox"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  networking.wireguard.enable = true;
  specialisation.mullvad.configuration = {
    networking.wg-quick.interfaces."za-jnb-wg-001" = {
      privateKey = "2DeV2nQeXkvpMo7ZOdIpWzgkmNZYy5nG8uvK+uNmn2o=";
      address = [
        "10.68.13.92/32"
        "fc00:bbbb:bbbb:bb01::5:d5b/128"
      ];
      dns = [
        "10.64.0.1"
      ];
      peers = [
        {
          publicKey = "5dOGXJ9JK/Bul0q57jsuvjNnc15gRpSO1rMbxkf4J2M=";
          allowedIPs = [
            "0.0.0.0/0"
            "::0/0"
          ];
          endpoint = "154.47.30.130:51820";
        }
      ];
    };
  };

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.usb-modeswitch.enable = true;

  services.acpid.enable = true;

  # Enable the X11 windowing system.

  specialisation."gnome".configuration = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
  
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  services.gnome.gnome-keyring.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.unprivilegedUsernsClone = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.jacom = {
    isNormalUser = true;
    description = "Jaco Malan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kitty
      zellij
    ];
  };

  programs.firefox.enable = true;

  # NixOS Dynamically linked binaries fix
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libspatialite
    libxml2
  ];
  
  programs.ssh.startAgent = false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = true;
    };
  };

  # Open ports in the firewall.
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 8384 22000 25565 22 ];
    allowedUDPPorts = [ 22000 21027 ];
  };

  # Do not remove
  system.stateVersion = "24.05";
}
