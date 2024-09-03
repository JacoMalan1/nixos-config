{ ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainbar = {
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "temperature" "tray" ];

        pulseaudio = {
          format =  "{volume}% {icon} {format_source}";
          format-bluetooth =  "{volume}% {icon} {format_source}";
          format-bluetooth-muted =  " {icon} {format_source}";
          format-muted =  " {format_source}";
          format-source =  "{volume}% ";
          format-source-muted =  "";
          format-icons =  {
              headphone =  "";
              hands-free =  "";
              headset =  "";
              phone =  "";
              portable =  "";
              car =  "";
              default =  [ "" "" "" ];
          };
        };

        cpu = {
          interval = 1;
          format = "{usage}% ";
          tooltip = false;
        };

        memory = {
          format = "{}% ";
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        tray = {
          spacing = 10;
        };

        temperature = {
          interval = 1;
          hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input";
          format = "{temperatureC}°C ";
          critical-threshold = 70;
        };
      };
    };
  };
}
