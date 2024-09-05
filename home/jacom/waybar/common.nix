{ ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainbar = {
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "pulseaudio" "cpu" "memory" "temperature" "tray" ];

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

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
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
          interval = 1;
          format-wifi = "{essid} ({signalStrength}%) {bandwidthDownBytes} ";
          format-ethernet = "{ipaddr}/{cidr} {bandwidthDownBytes} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        tray = {
          spacing = 10;
        };
      };
    };
  };
}
