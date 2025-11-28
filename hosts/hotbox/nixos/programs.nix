{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "dotnet-sdk-6.0.428" ];
    };
  };
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  dotnet-combined = (with pkgs.dotnetCorePackages;
    combinePackages [ sdk_6_0 dotnet_8.sdk dotnet_9.sdk dotnet_10.sdk ]).overrideAttrs
    (finalAttrs: previousAttrs:
      {
	postBuild = (previousAttrs.postBuild or '''') + ''
	  for i in $out/sdk/*
	  do
	    i=$(basename $i)
	    mkdir -p $out/metadata/workloads/''${i/-*}
	    touch $out/metadata/workloads/''${i/-*}/userlocal
	  done
	'';
      });
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
    rustup
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
    wireshark-qt
    dbeaver-bin
    freecad
    drawio
    xmrig
    pavucontrol
    wpsoffice
    wineWowPackages.waylandFull
    winetricks
    bitwig-studio
    obsidian
    dotnet-combined
    teams-for-linux
    yubioath-flutter
    remmina
  ]) ++ (with pkgs-unstable; [
    # Packages from nixpkgs-unstable
    lazygit
    gcc_multi
    libresplit
    tracy-wayland
    jetbrains.rider
    prusa-slicer
    monero-gui
    monero-cli
    signal-desktop
    easyeffects
    ledger-live-desktop
    thunderbird
    lutris
    renderdoc
    inputs.spotify.packages.${system}.default
  ]);
}
