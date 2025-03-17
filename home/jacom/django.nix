{ ... }: {
  imports = [ ./common.nix ./hyprland/django.nix ./waybar/django.nix ./nixvim ];

  xdg.desktopEntries = {
    spotify = {
      name = "Spotify";
      genericName = "Music Player";
      exec =
        "spotify --enable-features=UseOzonePlatform --ozone-platform=x11 %U";
      terminal = false;
      icon = "spotify-client";
      mimeType = [ "x-scheme-handler/spotify" ];
      categories = [ "Audio" "Music" "Player" "AudioVideo" ];
    };
    dbeaver = {
      name = "dbeaver-ce";
      genericName = "Universal Database Manager";
      terminal = false;
      comment = "Universal Database Manager and SQL Client";
      icon = "dbeaver";
      settings = { StartupWMClass = "DBeaver"; };
      startupNotify = true;
      mimeType = [ "application/sql" ];
      exec = "env GDK_BACKEND=x11 dbeaver";
    };
  };
}
