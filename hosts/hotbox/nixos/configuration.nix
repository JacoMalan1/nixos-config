# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ nixpkgs-unstable, nixpkgs-stable, ... }: 
let 
  pkgs = import nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
  pkgs-stable = import nixpkgs-stable { system = "x86_64-linux"; config.allowUnfree = true; };

  stablePackages = with pkgs-stable.pkgs; [
    leftwm
    rustdesk
    librewolf
  ];

  unstablePackages  = with pkgs.pkgs; [
    rofi
    polybar
    neovim
    zsh
    mesa
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
    usb-modeswitch
    usbutils
    networkmanagerapplet
    element-desktop
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
  ];
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  
  boot.kernelPackages = pkgs.linuxPackages_hardened;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "hotbox"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  environment.sessionVariables = {
    FLAKE = "$HOME/nix";
  };

  # Select internationalisation properties.

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  hardware.usb-modeswitch.enable = true;

  services.acpid.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.verbose = 7;

  # Enable the GNOME Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.windowManager.leftwm.enable = true;
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
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.unprivilegedUsernsClone = true;
  
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
      kitty
      zellij
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.hyprland.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = stablePackages ++ unstablePackages;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
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
