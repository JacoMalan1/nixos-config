{ inputs, ... }:
let
  pkgs = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
  fonts.packages = with pkgs.pkgs; [
    corefonts
    vistafonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    meslo-lgs-nf
    fira-code
    fira-code-symbols
    cantarell-fonts
    inter
    jetbrains-mono
  ];
}
