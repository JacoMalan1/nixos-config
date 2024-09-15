{ ... }: {
  imports = [ ./common.nix ];
  
  programs.waybar.settings.mainbar = {
    modules-right = [ "network" "pulseaudio" "cpu" "memory" "temperature" "battery" "tray" ];
  };
}
