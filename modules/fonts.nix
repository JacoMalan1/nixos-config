{ inputs, ... }:
let
  pkgs = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
  fonts.packages = with pkgs; [
    corefonts
    vista-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    meslo-lgs-nf
    fira-code
    fira-code-symbols
    cantarell-fonts
    inter
    jetbrains-mono
  ];
}
