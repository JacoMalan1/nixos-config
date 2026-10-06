{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "dotnet-sdk-6.0.428" "libsoup-2.74.3" ];
      rocmSupport = true;
    };
  };
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  rubberband2 = pkgs-unstable.rubberband.overrideAttrs (oldAttrs: {
    version = "3.3.0";
    src = pkgs-unstable.fetchurl {
      url = "https://breakfastquay.com/files/releases/rubberband-3.3.0.tar.bz2";
      hash = "sha256-2e+J4rjvn4WxOsPC+uww4grPLJ86nIxFzmN/K8leV2w=";
    };
    patches = [ ];
  });
  bitwig-studio-wrapped = pkgs-unstable.bitwig-studio.overrideAttrs (oldAttrs: {
    postFixup = (oldAttrs.postFixup or "") + ''
      wrapProgram $out/bin/bitwig-studio \
        --prefix LD_LIBRARY_PATH : ${pkgs-unstable.lib.makeLibraryPath (with pkgs-unstable; [
          freetype
          fontconfig
	  fftw
	  fftwFloat
	  aubio
	  soundtouch
	  rubberband2
	  stdenv.cc.cc.lib
        ])}
    '';
  });
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
    librewolf
    zsh
    mesa
    keepassxc
    zsh-powerlevel10k
    zsh-autosuggestions
    git
    eza
    bat
    discord
    prismlauncher
    pciutils
    usb-modeswitch
    usbutils
    networkmanagerapplet
    rustup
    psmisc
    lshw
    mesa-demos
    cmake
    gnumake
    pam_u2f
    xss-lock
    gnupg
    macchanger
    kdePackages.breeze
    grim

    nautilus
    gnome-disk-utility
    evince

    hyfetch
    onefetch
    btop

    lm_sensors
    zenmonitor
    unzip

    nodejs
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
    python3
    kdePackages.kcachegrind
    gperftools
    gv
    graphviz
    apitrace

    sage
    vlc
    go
    blender
    ghidra-bin
    brave
    firebase-tools

    zls
    zig

    gradle
    renderdoc
    libsForQt5.qt5.qtwayland

    stellarium
    wireshark-qt
    dbeaver-bin
    freecad
    xmrig
    pavucontrol
    obsidian
    dotnet-combined
    teams-for-linux
    yubioath-flutter
    remmina
    gparted
    texlive.combined.scheme-full
    tigervnc
    pandoc
    inkscape
    wineWow64Packages.stable
    winetricks
    qjackctl
  ]) ++ (with pkgs-unstable; [
    # Packages from nixpkgs-unstable
    lazygit
    gcc_multi
    libresplit
    jetbrains.rider
    prusa-slicer
    monero-gui
    monero-cli
    signal-desktop
    easyeffects
    ledger-live-desktop
    thunderbird
    renderdoc
    spotify
    android-studio
    furmark
    zellij
    android-tools
    lightgbm
    bottles
    glab
    winbox
  ]) ++ [
    bitwig-studio-wrapped
  ];
}
