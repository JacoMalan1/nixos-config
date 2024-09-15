{ ... }: {
  imports = [ ./common.nix ];

  programs.waybar.settings.mainbar = {
    modules-right = [ "network" "pulseaudio" "cpu" "memory" "temperature" "tray" ];
      
    temperature = {
      interval = 1;
      hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input";
      format = "{temperatureC}°C ";
      critical-threshold = 70;
    };
  };
}
