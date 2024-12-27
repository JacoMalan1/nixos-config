{ ... }: {
  imports = [ ./common.nix ];
  
  programs.waybar.settings.mainbar = {
    modules-right = [ "network" "cpu" "memory" "temperature" "battery" "backlight/slider" "tray" ];
  };
}
