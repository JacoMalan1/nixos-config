{ inputs, system, ... }:
let
  leftMonitor = "DP-3";
  rightMonitor = "HDMI-A-1";
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  imports = [ ./common.nix ];

  home.packages = with pkgs; [ hyprshot copyq ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [ "copyq --start-server" ];
    env = [ "ELECTRON_OZONE_PLATFORM_HINT,auto" "LIBVA_DRIVER_NAME,nvidia" ];
    bind = [
      "ALT, w, swapactiveworkspaces, ${rightMonitor} ${leftMonitor}"
      "ALT, h, focusmonitor, ${leftMonitor}"
      "ALT, l, focusmonitor, ${rightMonitor}"
      "SUPER, s, exec, hyprshot -o ~/Pictures -m region"
      "SUPER SHIFT, s, exec, hyprshot -o ~/Pictures -m window"
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
