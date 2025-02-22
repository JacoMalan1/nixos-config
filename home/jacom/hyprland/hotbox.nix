{ ... }:
let
  leftMonitor = "DP-3";
  rightMonitor = "HDMI-A-1";
in {
  imports = [ ./common.nix ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "ALT, w, swapactiveworkspaces, ${rightMonitor} ${leftMonitor}"
      "ALT, h, focusmonitor, ${leftMonitor}"
      "ALT, l, focusmonitor, ${rightMonitor}"
    ];

    windowrulev2 = [
      "workspace 1, initialclass:(steam_app_311210)"
      "tile, initialclass:(steam_app_311210)"
      "fullscreen, initialclass:(steam_app_311210)"
    ];

    monitor = [
      "${rightMonitor}, 1920x1080, 1920x0, 1"
      "${leftMonitor}, 1920x1080, 0x0, 1"
    ];
  };
}
