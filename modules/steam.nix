{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable { inherit system; config.allowUnfree = true; };
in
{
  programs.steam = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    gamemode
    gamescope
    mangohud
  ];
}
