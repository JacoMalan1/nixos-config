{ inputs, system, ... }:
let
  rightMonitor = "DP-2";
  leftMonitor = "HDMI-A-1";
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  imports = [ ./common.nix ];

  home.packages = with pkgs; [ hyprshot copyq wayvnc ];

  wayland.windowManager.hyprland.settings = {
    general.allow_tearing = true;
    exec-once = [ "copyq --start-server" ];
    env = [ "ELECTRON_OZONE_PLATFORM_HINT,auto" ];
    bind = [
      # "ALT, w, swapactiveworkspaces, ${rightMonitor} ${leftMonitor}"
      "ALT, h, focusmonitor, ${leftMonitor}"
      "ALT, l, focusmonitor, ${rightMonitor}"
      "SUPER, s, exec, hyprshot -o ~/Pictures -m region"
      "SUPER SHIFT, s, exec, hyprshot -o ~/Pictures -m window"
    ];

    windowrule = [
      "workspace 1, match:initial_class (steam_app_311210)"
      "tile on, match:initial_class (steam_app_311210)"
      "fullscreen on, match:initial_class (steam_app_311210)"
      "float on, match:initial_title (pisim)"
      "immediate on, match:initial_class (steam_app_3017860)"
    ];

    monitor = [
      "${rightMonitor}, 1920x1080@120, 1920x0, 1"
      "${leftMonitor}, 1920x1080, 0x0, 1"

    ];

    workspace = [
      "2, monitor:${leftMonitor}"
      "4, monitor:${leftMonitor}"
      "6, monitor:${leftMonitor}"
      "8, monitor:${leftMonitor}"
      "1, monitor:${rightMonitor}"
      "3, monitor:${rightMonitor}"
      "5, monitor:${rightMonitor}"
      "7, monitor:${rightMonitor}"
      "9, monitor:${rightMonitor}"
    ];
  };
}
