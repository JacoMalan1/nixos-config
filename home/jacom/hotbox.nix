{ ... }: {
  imports = [ ./common.nix ./hyprland/hotbox.nix ./waybar/hotbox.nix ./nixvim ./rofi ];

  programs.mangohud = {
    enable = true;
    settings = { position = "top-right"; };
  };
}
