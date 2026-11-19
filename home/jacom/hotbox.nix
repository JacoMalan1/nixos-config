{ pkgs, lib, ... }:
{
  imports = [
    ./common.nix
    ./hyprland/hotbox.nix
    ./nixvim
    ./rofi
    ./nextcloud.nix
    ./desktop-entries.nix
  ];

  home.file.".config/noctalia/config.toml".source = ./noctalia/hotbox.toml;

  xdg.desktopEntries = {
    ledger-live-desktop = {
      name = "Ledger Live";
      exec = "ledger-live-desktop --enable-features=UseOzonePlatform --ozone-platform=x11 --no-sandbox %U";
      terminal = false;
      icon = "ledger-live-desktop";
      settings = {
        StartupWMClass = "Ledger Live";
      };
      comment = "Ledger Live - Desktop";
      mimeType = [ "x-scheme-handler/ledgerlive" ];
      categories = [ "Finance" ];
    };
  };

  programs.mangohud = {
    enable = true;
    package = pkgs.stable.mangohud;
    settings = {
      position = "top-right";
    };
  };

  services.wlsunset.enable = lib.mkForce false;
}
