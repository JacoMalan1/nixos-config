{ inputs, lib, system, ... }:
let 
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
  mkExecBind = ({ bind, cmd }: {
    _args = [
      "${bind}"
      (lib.generators.mkLuaInline "hl.dsp.exec_cmd('${cmd}')")
    ];
  });
in {
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.dunst = {
    enable = false;
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

  services.hyprpolkitagent.enable = true;

  programs.hyprlock = {
    enable = false;
    package = pkgs.hyprlock;
    settings = {
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

  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      wallpaper = [
	{
	  monitor = "DP-3";
	  path = "/home/jacom/nix/home/jacom/gruvbox-wallpaper.jpg";
	}
	{
	  monitor = "HDMI-A-1";
	  path = "/home/jacom/nix/home/jacom/gruvbox-wallpaper.jpg";
	}
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    configType = "lua";
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    settings = {
      env = [
	{ _args = ["HYPRCURSOR_THEME" "Adwaita"]; }
	{ _args = ["HYPRCURSOR_SIZE" "24"]; }
        { _args = ["QT_QPA_PLATFORM" "wayland"]; }
      ];
      on = [
	{
	  _args = [
	    "hyprland.start"
	    (lib.generators.mkLuaInline "function()\nhl.exec_cmd(\"noctalia-shell\")\nhl.exec_cmd(\"easyeffects --service-mode -w\")\nhl.exec_cmd(\"keepassxc\")\nend")
	  ];
	}
      ];

      animation = [
	{
	  leaf = "global";
	  enabled = true;
	  speed = 2;
	  bezier = "default";
	}
      ];

      config = {
	ecosystem.enforce_permissions = false;
	general = {
	  border_size = 1;
	  gaps_in = 5;
	  gaps_out = 10;
	  "col.active_border" = "0xff98971a";
	  layout = "master";
	};
	decoration = { 
	  rounding = 20;
	  rounding_power = 2;

	  shadow = {
	    enabled = true;
	    range = 4;
	    render_power = 3;
	    color = "rgba(1a1a1aee)";
	  };

	  blur = {
	    enabled = true;
	    size = 3;
	    passes = 2;
	    vibrancy = 0.1696;
	  };
	};
	master = { mfact = 0.5; };
	input.accel_profile = "flat";
      };
      # windowrulev2 = "immediate,class:^(Minecraft.*)$";
      bind = let terminal = "kitty"; in [
	(mkExecBind { bind = "ALT + b"; cmd = "brave --ozone-platform=wayland --disable-features=WaylandWpColorManagerV1";})
	(mkExecBind { bind = "ALT + p"; cmd = "noctalia-shell ipc call launcher toggle"; })
	(mkExecBind { bind = "ALT + SHIFT + p"; cmd = "rofi -show run"; })
	(mkExecBind { bind = "SUPER + l"; cmd = "noctalia-shell ipc call lockScreen lock"; })
	(mkExecBind { bind = "ALT + SHIFT + Return"; cmd = terminal; })
	{ _args = ["ALT + SHIFT + 1" (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = '1', follow = false })")]; }
	{ _args = ["ALT + SHIFT + 2" (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = '2', follow = false })")]; }
	{ _args = ["ALT + SHIFT + 3" (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = '3', follow = false })")]; }
	{ _args = ["ALT + SHIFT + 4" (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = '4', follow = false })")]; }
	{ _args = ["ALT + SHIFT + 5" (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = '5', follow = false })")]; }
	{ _args = ["ALT + SHIFT + 6" (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = '6', follow = false })")]; }
	{ _args = ["ALT + SHIFT + 7" (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = '7', follow = false })")]; }
	{ _args = ["ALT + SHIFT + 8" (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = '8', follow = false })")]; }
	{ _args = ["ALT + SHIFT + 9" (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = '9', follow = false })")]; }

	{ _args = ["ALT + SHIFT + code:21" (lib.generators.mkLuaInline "hl.dsp.layout('mfact +0.05')")]; }
	{ _args = ["ALT + SHIFT + code:20" (lib.generators.mkLuaInline "hl.dsp.layout('mfact -0.05')")]; }
	{ _args = ["ALT + code:49" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 'emptynm' })")]; }

	{ _args = ["ALT + 1" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 1 })")]; }
	{ _args = ["ALT + 2" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 2 })")]; }
	{ _args = ["ALT + 3" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 3 })")]; }
	{ _args = ["ALT + 4" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 4 })")]; }
	{ _args = ["ALT + 5" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 5 })")]; }
	{ _args = ["ALT + 6" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 6 })")]; }
	{ _args = ["ALT + 7" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 7 })")]; }
	{ _args = ["ALT + 8" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 8 })")]; }
	{ _args = ["ALT + 9" (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 9 })")]; }
        
	{ _args = ["ALT + SHIFT + q" (lib.generators.mkLuaInline "hl.dsp.window.close()")]; }
	{ _args = ["ALT + j" (lib.generators.mkLuaInline "hl.dsp.window.cycle_next()")]; }
	{ _args = ["ALT + k" (lib.generators.mkLuaInline "hl.dsp.window.cycle_next({ next = false })")]; }
	{ _args = ["ALT + SHIFT + j" (lib.generators.mkLuaInline "hl.dsp.window.swap({ next = true })")]; }
	{ _args = ["ALT + SHIFT + k" (lib.generators.mkLuaInline "hl.dsp.window.swap({ prev = true })")]; }
	{ _args = ["ALT + f" (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({ mode = 'fullscreen', action = 'toggle' })")]; }
	{ _args = ["ALT + SHIFT + x" (lib.generators.mkLuaInline "hl.dsp.exit()")]; }
	{ _args = ["ALT + SHIFT + f" (lib.generators.mkLuaInline "hl.dsp.window.float({ action = 'toggle' })")]; }

	# --------- Special workspaces -----------
	{ _args = ["ALT + c" (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special('calculator')")]; }
	(mkExecBind { bind = "ALT + c"; cmd = "pgrep qalculate-gtk || qalculate-gtk &"; })

	{ _args = ["ALT + v" (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special('obsidian')")]; }
	(mkExecBind { bind = "ALT + v"; cmd = "pgrep -a electron | grep obsidian || obsidian &"; })

	{ _args = ["ALT + t" (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special('thunderbird')")]; }
	(mkExecBind { bind = "ALT + t"; cmd = "pgrep thunderbird || thunderbird &"; })

	{ _args = ["ALT + SHIFT + t" (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special('teams')")]; }
	(mkExecBind { bind = "ALT + SHIFT + t"; cmd = "pgrep -a electron | grep teams-for-linux || teams-for-linux &"; })

	{ _args = ["ALT + s" (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special('spotify')")]; }
	(mkExecBind { bind = "ALT + s"; cmd = "pgrep .spotify-wrappe || spotify --enable-features=UseOzonePlatform --ozone-platform=x11 &"; })

	{ _args = ["ALT + a" (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special('yubioath')")]; }
	(mkExecBind { bind = "ALT + a"; cmd = "pgrep .yubioath-flutt || yubioath-flutter &"; })

	{ _args = ["SUPER + k" (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special('keepassxc')")]; }
	(mkExecBind { bind = "SUPER + k"; cmd = "keepassxc"; })
	# ----------------------------------------

	(mkExecBind { bind = "ALT + SHIFT + c"; cmd = "copyq toggle"; })

	{ _args = ["ALT + SHIFT + v" (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special('netextender')")]; }

	{ _args = ["XF86AudioPlay" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('playerctl play-pause')") { locked = true; }]; }
	{ _args = ["XF86AudioPause" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('playerctl play-pause')") { locked = true; }]; }
	{ _args = ["XF86AudioPrev" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('playerctl previous')") { locked = true; }]; }
	{ _args = ["XF86AudioNext" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('playerctl next')") { locked = true; }]; }

	{ _args = ["SUPER + mouse:272" (lib.generators.mkLuaInline "hl.dsp.window.drag()") { mouse = true; }]; }
	{ _args = ["SUPER + mouse:273" (lib.generators.mkLuaInline "hl.dsp.window.resize()") { mouse = true; }]; }
      ];

      window_rule = [
	{ match.class = "Tor Browser"; float = true; }
	{ match.class = "qalculate-gtk"; float = true; workspace = "special:calculator"; }
	{ match.class = "obsidian"; workspace = "special:obsidian"; }
	{ match.class = "thunderbird"; workspace = "special:thunderbird"; }
	{ match.class = "Spotify"; workspace = "special:spotify"; }
	{ match.class = "yubioath-flutter"; workspace = "special:yubioath"; float = true; }
	{ match.class = "teams-for-linux"; workspace = "special:teams"; }
	{ match.class = "NetExtender"; workspace = "special:netextender"; float = true; size = "{\"50%\", \"50%\"}"; }
	{ match.class = "org\\.keepassxc\\.KeePassXC"; float = true; workspace = "special:keepassxc"; }
	{ match.class = "com\\.github\\.hluk\\.copyq"; float = true; size = "{\"50%\", \"50%\"}"; }
      ];

      layer_rule = [
	{
	  name = "noctalia";
	  match.namespace = "noctalia-background-,*$";
	  ignore_alpha = 0.5;
	  blur = true;
	  blur_popups = true;
	}
      ];
    };
  };
}
