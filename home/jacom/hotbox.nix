{ ... }: {
  imports =
    [ ./common.nix ./hyprland/hotbox.nix ./waybar/hotbox.nix ./nixvim.nix ];

  programs.mangohud = {
    enable = true;
    settings = { position = "top-right"; };
  };
}
