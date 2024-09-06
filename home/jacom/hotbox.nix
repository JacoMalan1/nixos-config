{ ... }:
{
  imports = [
    ./common.nix
    ./hyprland/hotbox.nix
    ./waybar/hotbox.nix
  ];

  programs.mangohud = {
    enable = true;
    settings = {
      position = "top-right";
    };
  };
}
