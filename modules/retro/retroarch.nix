{ inputs, system, ... }: 
let
  pkgs = import inputs.nixpkgs-unstable { inherit system; config.allowUnfree = true; };
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; config.allowUnfree = true; };
in
{
  environment.systemPackages = with pkgs-stable; [
    retroarchFull
    retroarch-joypad-autoconfig
    retroarch-assets
  ];
}
