{ ... }: {
  imports = [ ./common.nix ./hyprland/hotbox.nix ./waybar/hotbox.nix ./nixvim ];

  programs.mangohud = {
    enable = true;
    settings = { position = "top-right"; };
  };
}
