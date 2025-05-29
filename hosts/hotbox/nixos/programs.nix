{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  # System packages
  environment.systemPackages = (with pkgs; [
    # Packages from stable 24.05
    librewolf
    rustdesk
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
    nautilus
    gnome-disk-utility
    evince

    neofetch
    onefetch
    btop

    lm_sensors
    zenmonitor
    unzip

    nodejs_20
    yarn

    gmp
    mpfr

    direnv
    nix-direnv
    mprocs
    inetutils
    ripgrep
    fzf
    flat-remix-icon-theme
    xorg.xcursorthemes
    lxappearance
    gimp
    jdk21
    jdk17
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
    firebase-tools

    wineWowPackages.stable

    android-tools
    zls
    zig
    godot_4

    gradle
    renderdoc
    libsForQt5.qt5.qtwayland

    stellarium
    thunderbird
    inputs.strain.defaultPackage.${system}
    wireshark-qt
    dbeaver-bin
    freecad
    drawio
  ]) ++ (with pkgs-unstable; [
    # Packages from nixpkgs-unstable
    lazygit
    gcc_multi
    libresplit
    musescore
    tracy-wayland
    jetbrains.rider
    prusa-slicer
    spotify
    monero-gui
  ]);
}
