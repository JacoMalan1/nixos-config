{ inputs, system, ... }: 
let
  pkgs = import inputs.nixpkgs-stable { 
    inherit system; 
    config.allowUnfree = true; 
    overlays = [
      (final: prev: {
        strain = inputs.strain.defaultPackage.${system};
      })
    ];
  };
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; config.allowUnfree = true; };

  rstudio-override = pkgs-unstable.rstudioWrapper.override { 
    packages = with pkgs-unstable.rPackages; [ 
      ggplot2 
      dplyr 
      tidyverse
      maps
      rnaturalearth
      rnaturalearthdata
      gganimate
      sf
      gifski
    ]; 
  };
in
{
  # System packages
  environment.systemPackages = (with pkgs; [
    # Packages from stable 24.05
    librewolf
    rustdesk
    spotify
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
    prismlauncher
    pciutils
    usb-modeswitch
    usbutils
    networkmanagerapplet
    fluffychat
    signal-desktop
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
    xss-lock
    gnupg
    macchanger
    kdePackages.breeze
    scrot
    
    # GNOME utilities
    gnome.nautilus
    gnome.gnome-disk-utility
    evince
    
    neofetch
    onefetch
    btop

    lm_sensors
    zenmonitor
    playerctl
    unzip

    nodejs_20
    yarn

    gmp
    mpfr

    direnv
    nix-direnv
    mprocs
    strain
  ]) ++ ([
    # Packages from nixpkgs-unstable
    rstudio-override
  ]);
}
