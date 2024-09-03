{ ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        color = "rgba(128, 128, 128, 1.0)";
      };
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "HYPRCURSOR_THEME,Adwaita"
        "HYPRCURSOR_SIZE,24"
      ];
      exec-once = [
        "waybar"
        "redshift -l -29:24"
        "easyeffects --gapplication-service"
        "keepassxc & disown"
        "dunst & disown"
      ];
      animation = "global, 1, 2, default";
      general = {
        allow_tearing = true;
        gaps_out = 10;
      };
      bind = [
        "ALT, b, exec, librewolf"
        "ALT, p, exec, rofi -show drun -show-icons"
        "CTRL ALT, l, exec, hyprlock --immediate"
        "ALT SHIFT, Return, exec, kitty"
        "ALT SHIFT, 1, movetoworkspacesilent, 1"
        "ALT SHIFT, 2, movetoworkspacesilent, 2"
        "ALT SHIFT, 3, movetoworkspacesilent, 3"
        "ALT SHIFT, 4, movetoworkspacesilent, 4"
        "ALT SHIFT, 5, movetoworkspacesilent, 5"
        "ALT SHIFT, 6, movetoworkspacesilent, 6"
        "ALT SHIFT, 7, movetoworkspacesilent, 7"
        "ALT SHIFT, 8, movetoworkspacesilent, 8"
        "ALT SHIFT, 9, movetoworkspacesilent, 9"
        "ALT, 1, focusworkspaceoncurrentmonitor, 1"
        "ALT, 2, focusworkspaceoncurrentmonitor, 2"
        "ALT, 3, focusworkspaceoncurrentmonitor, 3"
        "ALT, 4, focusworkspaceoncurrentmonitor, 4"
        "ALT, 5, focusworkspaceoncurrentmonitor, 5"
        "ALT, 6, focusworkspaceoncurrentmonitor, 6"
        "ALT, 7, focusworkspaceoncurrentmonitor, 7"
        "ALT, 8, focusworkspaceoncurrentmonitor, 8"
        "ALT, 9, focusworkspaceoncurrentmonitor, 9"
        "ALT SHIFT, q, killactive"
        "ALT, j, cyclenext"
        "ALT, k, cyclenext, prev"
        "ALT, h, focusmonitor, DP-3"
        "ALT, l, focusmonitor, HDMI-A-2"
        "ALT, f, fullscreen"
        "ALT SHIFT, x, exit"
      ];
      bindm = [
        "SUPER, mouse:272, movewindow"
      ];
      monitor = [
        "HDMI-A-2, 1920x1080, 1920x0, 1"
        "DP-3, 1920x1080, 0x0, 1"
      ];
      input.accel_profile = "flat";
    };
  };
}
