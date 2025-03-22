{ ... }:
let
  leftMonitor = "DP-3";
  rightMonitor = "HDMI-A-1";
in {
  imports = [ ./common.nix ];

  wayland.windowManager.hyprland.settings = {
    env = [ "ELECTRON_OZONE_PLATFORM_HINT,auto" "LIBVA_DRIVER_NAME,nvidia" ];
    bind = [
      "ALT, w, swapactiveworkspaces, ${rightMonitor} ${leftMonitor}"
      "ALT, h, focusmonitor, ${leftMonitor}"
      "ALT, l, focusmonitor, ${rightMonitor}"
    ];

    windowrulev2 = [
      "workspace 1, initialclass:(steam_app_311210)"
      "tile, initialclass:(steam_app_311210)"
      "fullscreen, initialclass:(steam_app_311210)"
      "float, initialTitle:(pisim)"
    ];

    monitor = [
      "${rightMonitor}, 1920x1080, 1920x0, 1"
      "${leftMonitor}, 1920x1080, 0x0, 1"
    ];
  };
}
