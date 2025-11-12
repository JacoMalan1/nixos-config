{ inputs, system, ... }:
let
  rightMonitor = "DP-3";
  leftMonitor = "HDMI-A-1";
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  imports = [ ./common.nix ];

  home.packages = with pkgs; [ hyprshot copyq ];

  wayland.windowManager.hyprland.settings = {
    general.allow_tearing = true;
    exec-once = [ "copyq --start-server" ];
    env = [ "ELECTRON_OZONE_PLATFORM_HINT,auto" "LIBVA_DRIVER_NAME,nvidia" ];
    bind = [
      "ALT, w, swapactiveworkspaces, ${rightMonitor} ${leftMonitor}"
      "ALT, h, focusmonitor, ${leftMonitor}"
      "ALT, l, focusmonitor, ${rightMonitor}"
      "SUPER, s, exec, hyprshot -o ~/Pictures -m region"
      "SUPER SHIFT, s, exec, hyprshot -o ~/Pictures -m window"
    ];

    windowrule = [
      "workspace 1, initialClass:(steam_app_311210)"
      "tile, initialClass:(steam_app_311210)"
      "fullscreen, initialClass:(steam_app_311210)"
      "float, initialTitle:(pisim)"
      # "immediate, class:^Minecraft. 1.21.5$"
    ];

    monitor = [
      "${rightMonitor}, 1920x1080@120, 1920x0, 1"
      "${leftMonitor}, 1920x1080, 0x0, 1"
    ];
  };
}
