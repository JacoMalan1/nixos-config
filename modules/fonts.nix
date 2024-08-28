{ inputs, ... }:
  let
    pkgs = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
  in
  {
    fonts.packages = with pkgs.pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      meslo-lgs-nf
      fira-code
      fira-code-symbols
      cantarell-fonts
      inter
    ];
  }
