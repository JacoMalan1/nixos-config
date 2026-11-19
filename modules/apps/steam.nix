{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
  ];

  programs.gamemode.enable = true;
}
