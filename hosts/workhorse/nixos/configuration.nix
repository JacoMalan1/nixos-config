# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, nixpkgs-stable, nixpkgs-unstable, ... }:
let 
  pkgs = import nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
  pkgs-stable = import nixpkgs-stable { system = "x86_64-linux"; config.allowUnfree = true; };

  stablePackages = with pkgs-stable.pkgs; [
    leftwm
    librewolf
  ];

  unstablePackages  = with pkgs.pkgs; [
    rofi
    polybar
    neovim
    zsh
    keepassxc
    zsh-powerlevel10k
    zsh-autosuggestions
    git
    eza
    bat
    dust
    discord
    picom
    prismlauncher
    feh
    dunst
    pciutils
    usbutils
    networkmanagerapplet
    signal-desktop
    spotify
    gitui
    gcc_multi
    rustup
    easyeffects
    psmisc
    xorg.xkill
    lshw
    glxinfo
    cmake
    gnumake
    pam_u2f
    i3lock
    xss-lock
    gnupg
    macchanger
    kdePackages.breeze
    scrot
    
    # GNOME utilities
    nautilus
    gnome-disk-utility
    evince
    
    neofetch
    onefetch
    btop
    kitty
    zellij
  ];
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-80fbbdb8-4d23-41c0-bc30-39349cb3d4aa".device = "/dev/disk/by-uuid/80fbbdb8-4d23-41c0-bc30-39349cb3d4aa";
  boot.initrd.luks.devices."crypthome".device = "/dev/disk/by-uuid/bdfc4478-2c1e-4562-81ed-188060f346e4";
  fileSystems."/home".device = "/dev/mapper/crypthome";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "workhorse"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  environment.sessionVariables = {
    FLAKE = "$HOME/nix";
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.windowManager.leftwm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
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
  users.users.jacom = {
    isNormalUser = true;
    description = "Jaco Malan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = stablePackages ++ unstablePackages;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
