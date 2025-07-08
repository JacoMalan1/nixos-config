{ ... }: {
  imports = [
    ./common.nix
    ./waybar/workhorse.nix
    ./hyprland/workhorse.nix
    ./nixvim
    ./rofi
  ];

  nixvim.enable = true;
}
