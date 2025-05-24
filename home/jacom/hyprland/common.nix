{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
	background = "#3c3836";
	offset = "20x50";
      };
      urgency_low = {
	frame_color = "#458588";
	foreground = "#458588";
      };
      urgency_normal = {
	frame_color = "#98971a";
	foreground = "#98971a";
      };
      urgency_critical = {
	frame_color = "#cc241d";
	foreground = "#cc241d";
      };
    };
  };
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
    settings = {
      general = { immediate_render = true; };

      background = { color = "rgba(128, 128, 128, 1.0)"; };

      input-field = {
        size = "200, 50";
        outline_thickness = 3;
        dots_size = 0.33;
        dots_spacing = 0.15;
        dots_center = false;
        dots_rounding = -1;
        outer_color = "rgb(151515)";
        inner_color = "rgb(200, 200, 200)";
        font_color = "rgb(10, 10, 10)";
        fade_on_empty = true;
        fade_timeout = 1000;
        placeholder_text = "<i>Input Password...</i>";
        hide_input = false;
        rounding = -1;
        check_color = "rgb(204, 136, 34)";
        fail_color = "rgb(204, 34, 34)";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        fail_timeout = 2000;
        fail_transition = 300;
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1;
        invert_numlock = false;
        swap_font_color = false;
        position = "0, -20";
        halign = "center";
        valign = "center";
      };
    };
  };

  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      preload = "/home/jacom/nix/home/jacom/gruvbox-wallpaper.jpg";
      wallpaper = ", /home/jacom/nix/home/jacom/gruvbox-wallpaper.jpg";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    settings = {
      env = [
        "HYPRCURSOR_THEME,Adwaita"
        "HYPRCURSOR_SIZE,24"
        "QT_QPA_PLATFORM,wayland"
      ];
      exec-once = [
        "waybar & disown"
        "easyeffects --gapplication-service"
        "keepassxc & disown"
      ];
      animation = "global, 1, 2, default";
      general = {
	border_size = 1;
        gaps_out = 10;
	"col.active_border" = "0xff98971a";
        layout = "master";
      };
      decoration = {
	rounding = 10;
      };
      master = { mfact = 0.5; };
      # windowrulev2 = "immediate,class:^(Minecraft.*)$";
      bind = [
        "ALT, b, exec, brave"
        "ALT, p, exec, rofi -show drun -show-icons"
        "ALT SHIFT, p, exec, rofi -show run"
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
        "ALT SHIFT, code:21, layoutmsg, mfact +0.05"
        "ALT SHIFT, code:20, layoutmsg, mfact -0.05"
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
        "ALT SHIFT, j, swapnext"
        "ALT SHIFT, k, swapnext, prev"
        "ALT, k, cyclenext, prev"
        "ALT, f, fullscreen"
        "ALT SHIFT, x, exit"
        "ALT SHIFT, f, togglefloating"
        "ALT, c, togglespecialworkspace, calculator"
        "ALT, c, exec, pgrep qalculate-gtk || qalculate-gtk &"
	"ALT, v, togglespecialworkspace, obsidian"
	"ALT, v, exec, pgrep -a electron | grep obsidian || obsidian &"
	"ALT, t, togglespecialworkspace, thunderbird"
	"ALT, t, exec, pgrep thunderbird || thunderbird &"
	"ALT SHIFT, t, togglespecialworkspace, teams"
	"ALT SHIFT, t, exec, pgrep -a electron | grep teams-for-linux || teams-for-linux &"
	"ALT, s, togglespecialworkspace, spotify"
	"ALT, s, exec, pgrep .spotify-wrappe || spotify --enable-features=UseOzonePlatform --ozone-platform=x11 &"
	"ALT, a, togglespecialworkspace, yubioath"
	"ALT, a, exec, pgrep .yubioath-flutt || yubioath-flutter &"
	"SUPER, k, togglespecialworkspace, keepassxc"
	"SUPER, k, exec, keepassxc"
	"ALT SHIFT, c, exec, copyq toggle"
      ];
      bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];
      bindm =
        [ "SUPER, mouse:272, movewindow" "SUPER, mouse:273, resizewindow" ];

      input.accel_profile = "flat";

      windowrulev2 = [
        "float, class:(Tor Browser)"
        "float, class:(qalculate-gtk)"
        "workspace special:calculator, class:qalculate-gtk"
	"workspace special:obsidian, class:obsidian"
	"workspace special:thunderbird, class:thunderbird"
	"workspace special:spotify, class:Spotify"
	"workspace special:yubioath, class:yubioath-flutter"
	"workspace special:teams, class:teams-for-linux"
	"float, class:yubioath-flutter"
	"float, class:(org\\.keepassxc\\.KeePassXC)"
	"workspace special:keepassxc, class:org\\.keepassxc\\.KeePassXC"
	"float, class:copyq"
	"size 40% 40%, class:copyq"
      ];
    };
  };
}
