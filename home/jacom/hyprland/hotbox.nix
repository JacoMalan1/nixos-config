{ ... }: {
  imports = [ ./common.nix ];

  wayland.windowManager.hyprland.settings = {
    bind = [ "ALT, w, swapactiveworkspaces, HDMI-A-2 DP-3" ];

    windowrulev2 = [
      "workspace 1, initialclass:(steam_app_311210)"
      "tile, initialclass:(steam_app_311210)"
      "fullscreen, initialclass:(steam_app_311210)"
    ];

    monitor = [ "HDMI-A-2, 1920x1080, 1920x0, 1" "DP-3, 1920x1080, 0x0, 1" ];
  };
}
