{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  services.xserver.windowManager.leftwm.enable = true;

  environment.systemPackages = [
    pkgs-stable.leftwm
    pkgs.rofi
    pkgs.dmenu
    pkgs.polybarFull
    pkgs.picom
    pkgs.dunst
    pkgs.i3lock
    pkgs.redshift
    pkgs.feh
  ];
}
