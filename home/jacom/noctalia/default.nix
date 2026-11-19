{ ... }:
{
  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "${../gruvbox-wallpaper.jpg}";
    };
  };

  programs.noctalia = {
    enable = true;
  };
}
