{ inputs, system, lib, ... }:
let
  rightMonitor = "DP-2";
  leftMonitor = "HDMI-A-1";
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  imports = [ ./common.nix ];

  home.packages = with pkgs; [ hyprshot copyq wayvnc ];

  wayland.windowManager.hyprland.settings = {
    config = {
      general.allow_tearing = false;
    };

    on = [
      {
	_args = [
	  "hyprland.start"
	  (lib.generators.mkLuaInline "function()\nhl.dsp.exec_cmd('copyq --start-server')\nend")
	];
      }
    ];

    env = [ 
      { _args = ["ELECTRON_OZONE_PLATFORM_HINT" "auto"]; } 
    ];

    bind = [
      { _args = ["ALT + h" (lib.generators.mkLuaInline "hl.dsp.focus({ monitor = '${leftMonitor}' })")]; }
      { _args = ["ALT + l" (lib.generators.mkLuaInline "hl.dsp.focus({ monitor = '${rightMonitor}' })")]; }
      { _args = ["SUPER + s" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('hyprshot -o ~/Pictures -m region')")]; }
      { _args = ["SUPER + SHIFT + s" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('hyprshot -o ~/Pictures -m window')")]; }
    ];

    window_rule = [
      { match.initial_class = "steam_app_311210"; workspace = 1; float = false; fullscreen = true; }
    ];

    monitor = [
      { output = "${rightMonitor}"; mode = "1920x1080@120"; position = "1920x0"; scale = 1; }
      { output = "${leftMonitor}"; mode = "1920x1080"; position = "0x0"; scale = 1; }
    ];

    workspace_rule = [
      { workspace = "2"; monitor = "${leftMonitor}"; }
      { workspace = "4"; monitor = "${leftMonitor}"; }
      { workspace = "6"; monitor = "${leftMonitor}"; }
      { workspace = "8"; monitor = "${leftMonitor}"; }
      
      { workspace = "1"; monitor = "${rightMonitor}"; }
      { workspace = "3"; monitor = "${rightMonitor}"; }
      { workspace = "5"; monitor = "${rightMonitor}"; }
      { workspace = "7"; monitor = "${rightMonitor}"; }
      { workspace = "9"; monitor = "${rightMonitor}"; }
    ];
  };
}
