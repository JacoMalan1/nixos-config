{ pkgs, ... }: 
{
  imports = [ ./common.nix ];
  wayland.windowManager.hyprland = {
    package = pkgs.hyprland;
    settings = {
      monitor = [
        "eDP-1, 1920x1080, 0x0, 1"
      ];
      input.touchpad.natural_scroll = true;
    };
  };
}
