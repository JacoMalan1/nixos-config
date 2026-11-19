{ ... }: {
  imports = [
    ./common.nix
    ./hyprland/django.nix
    ./nixvim
    ./mpv
    ./desktop-entries.nix
  ];

  home.file.".config/noctalia/config.toml".source = ./noctalia/django.toml;

  xdg.desktopEntries = {
    signal-desktop = {
      name = "Signal";
      exec = "signal-desktop --enable-features=UseOzonePlatform --ozone-platform=x11 %U";
      comment = "Private messaging from your desktop";
      terminal = false;
      icon = "signal-desktop";
      mimeType = [
        "x-scheme-handler/sgnl"
        "x-scheme-handler/signalcaptcha"
      ];
      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];
    };
  };
}
