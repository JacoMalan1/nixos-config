{ pkgs, ... }:
let
  rubberband2 = pkgs.unstable.rubberband.overrideAttrs (oldAttrs: {
    version = "3.3.0";
    src = pkgs.unstable.fetchurl {
      url = "https://breakfastquay.com/files/releases/rubberband-3.3.0.tar.bz2";
      hash = "sha256-2e+J4rjvn4WxOsPC+uww4grPLJ86nIxFzmN/K8leV2w=";
    };
    patches = [ ];
  });
  bitwig-studio-wrapped = pkgs.unstable.bitwig-studio.overrideAttrs (oldAttrs: {
    postFixup = (oldAttrs.postFixup or "") + ''
      wrapProgram $out/bin/bitwig-studio \
        --prefix LD_LIBRARY_PATH : ${
          pkgs.unstable.lib.makeLibraryPath (
            with pkgs.unstable;
            [
              freetype
              fontconfig
              fftw
              fftwFloat
              aubio
              soundtouch
              rubberband2
              stdenv.cc.cc.lib
            ]
          )
        }
    '';
  });
in
{
  # System packages
  environment.systemPackages =
    (with pkgs; [
      prismlauncher
      usb-modeswitch
      networkmanagerapplet
      kdePackages.breeze
      grim

      hyfetch
      (btop.override { rocmSupport = true; })

      zenmonitor

      nodejs

      gmp
      mpfr

      mprocs
      inetutils
      flat-remix-icon-theme
      xorg.xcursorthemes
      lxappearance
      gimp
      jdk17
      kdePackages.kcachegrind
      gperftools
      gv
      graphviz
      apitrace

      sage
      go
      (blender.override { rocmSupport = true; })
      ghidra-bin
      firebase-tools

      zls
      zig

      gradle
      renderdoc
      libsForQt5.qt5.qtwayland

      stellarium
      freecad
      pavucontrol
      remmina
      tigervnc
      pandoc
      wineWow64Packages.stable
      winetricks
      qjackctl
      mqtt-explorer
      kdePackages.kdenlive
    ])
    ++ (with pkgs.unstable; [
      # Packages from nixpkgs-unstable
      libresplit
      renderdoc
      furmark
      lightgbm
      bottles
      glab
    ])
    ++ [
      bitwig-studio-wrapped
    ];
}
