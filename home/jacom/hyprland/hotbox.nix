{ ... }: {
  imports = [ ./common.nix ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-2, 1920x1080, 1920x0, 1"
      "DP-3, 1920x1080, 0x0, 1"
    ];
  };
}
