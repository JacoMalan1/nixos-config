{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      dust
      xorg.xkill
      scrot
      btop
      kitty
      leftwm

      brightnessctl
      exfat
      dolphin-emu
      wiimms-iso-tools
      ntfs3g
      steam-run
      unrar
      p7zip
      rpi-imager
      gcc-arm-embedded
      hyprpolkitagent
      vscode-fhs
      icu
      maven
      pwvucontrol
      drawio
      slurp
      hicolor-icon-theme
      wireguard-ui
      mpv
      vulkan-validation-layers
      obs-studio
    ]
    ++ (with pkgs.unstable; [
      nodejs_22
      eigenwallet
      blender
      fastfetch
    ]);
}
