{ pkgs, ... }:
{
  services.protonmail-bridge = {
    enable = true;
    path = with pkgs; [
      pass
      gnome-keyring
    ];
  };
}
