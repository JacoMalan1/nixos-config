{ inputs, lib, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
  rightMonitor = "HDMI-A-1";
  leftMonitor = "eDP-1";
in {
  imports = [ ./common.nix ];

  programs.hyprlock.package = lib.mkForce pkgs.hyprlock;
  wayland.windowManager.hyprland = {
    package = lib.mkForce pkgs.hyprland;
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
        "${leftMonitor}, 1920x1080, 0x0, 1"
      ];
    };
  };
}
