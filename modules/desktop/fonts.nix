{ pkgs, ... }:
{
  fonts.packages = with pkgs.unstable; [
    corefonts
    vista-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    meslo-lgs-nf
    fira-code
    fira-code-symbols
    inter
    jetbrains-mono
  ];
}
