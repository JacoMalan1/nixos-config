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
      caret
      car
      mlbench
      pROC
      clValid
      cluster
      tm
      word2vec
      syuzhet
      SnowballC
      topicmodels
      textstem
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
    signal-desktop
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
    grim
    
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
    inetutils
    ripgrep
    fzf
    dig
    flat-remix-icon-theme
    xorg.xcursorthemes
    lxappearance
    gimp
    sshfs
    jdk21
    postman
    anydesk
    python3
    kdePackages.kcachegrind
    gperftools
    gv
    graphviz
    apitrace
    wine64

    sage
    vlc
    go
    kdePackages.kdenlive
    blender
    ghidra-bin
    brave
  ]) ++ (with pkgs-unstable; [
    # Packages from nixpkgs-unstable
    lazygit
    gcc_multi
    libresplit
  ]) ++ ([
    rstudio-override
  ]);
}
