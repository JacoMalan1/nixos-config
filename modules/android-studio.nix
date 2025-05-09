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
  programs.nix-ld.libraries = with pkgs; [
    xorg.libX11
    xorg.libxcb
    xorg.libXi
    xorg.libXext
    xorg.libxkbfile
    libpulseaudio
    libpng
    nss
    nspr
    expat
    libdrm
    libbsd
  ];

  environment.systemPackages = with pkgs-unstable;
    [ android-studio ] ++ (with pkgs; [ android-tools qt5.qtwayland ]);
}
