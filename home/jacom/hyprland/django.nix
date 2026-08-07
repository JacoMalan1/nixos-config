{ inputs, lib, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
  rightMonitor = "HDMI-A-1";
  leftMonitor = "eDP-1";
in {
  imports = [ ./common.nix ];

  xdg.portal.enable = lib.mkForce false;

  home.packages = with pkgs; [ hyprshot copyq ];

  programs.hyprlock.package = lib.mkForce pkgs.hyprlock;
  services.hyprpaper.package = lib.mkForce pkgs.hyprpaper;

  wayland.windowManager.hyprland = {
    package = lib.mkForce null;
    portalPackage = lib.mkForce null;

    settings = {
on = [
      {
	_args = [
	  "hyprland.start"
	  (lib.generators.mkLuaInline "function()\nhl.dsp.exec_cmd('copyq --start-server')\nend")
	];
      }
    ];
      config = {
	input.touchpad.natural_scroll = true;
      };
      bind = [
	{ _args = ["ALT + w" (lib.generators.mkLuaInline "hl.dsp.workspace.swap_monitors({ monitor1 = '${leftMonitor}', monitor2 = '${rightMonitor}' })")]; }
	{ _args = ["ALT + h" (lib.generators.mkLuaInline "hl.dsp.focus({ monitor = '${leftMonitor}' })")]; }
	{ _args = ["ALT + l" (lib.generators.mkLuaInline "hl.dsp.focus({ monitor = '${rightMonitor}' })")]; }
	{ _args = ["SUPER + s" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('hyprshot -o ~/Pictures -m region')")]; }
	{ _args = ["SUPER + SHIFT + s" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('hyprshot -o ~/Pictures -m window')")]; }
      ];
      monitor = [
	{ output = "${leftMonitor}"; mode = "2880x1620@120.00"; position = "0x0"; scale = 1.5; }
	{ output = "${rightMonitor}"; mode = "1920x1080"; position = "2880x0"; scale = 1; }
      ];
    };
  };
}
