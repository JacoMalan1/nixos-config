{ inputs, lib, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  imports = [ ./common.nix ];

  programs.hyprlock.package = lib.mkForce pkgs.hyprlock;
  wayland.windowManager.hyprland = {
    package = lib.mkForce pkgs.hyprland;
    settings = {
      debug = { disable_logs = false; };
      monitor = [ "eDP-1, 1920x1080, 0x0, 1" ];
      input.touchpad.natural_scroll = true;
    };
  };
}
