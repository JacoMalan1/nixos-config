{ inputs, lib, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
  rightMonitor = "HDMI-A-1";
  leftMonitor = "eDP-1";
in {
  imports = [ ./common.nix ];

  xdg.portal.extraPortals = lib.mkForce [ pkgs.xdg-desktop-portal-gtk ];

  programs.hyprlock.package = lib.mkForce pkgs.hyprlock;
  services.hypridle.package = lib.mkForce pkgs.hypridle;
  services.hyprpaper.package = lib.mkForce pkgs.hyprpaper;

  wayland.windowManager.hyprland = {
    package = lib.mkForce pkgs.hyprland;
    portalPackage = lib.mkForce pkgs.xdg-desktop-portal-hyprland;
    settings = {
      debug = { disable_logs = false; };
      input.touchpad.natural_scroll = true;
      bind = [
        "ALT, w, swapactiveworkspaces, ${rightMonitor} ${leftMonitor}"
        "ALT, h, focusmonitor, ${leftMonitor}"
        "ALT, l, focusmonitor, ${rightMonitor}"
      ];
      monitor = [
        "${rightMonitor}, 1920x1080, 1920x0, 1"
        "${leftMonitor}, 2880x1620@120.00, 0x0, 1.5"
      ];
      windowrulev2 = [
        "minsize 1 1, class:^(spotify)$"
      ];
    };
  };
}
