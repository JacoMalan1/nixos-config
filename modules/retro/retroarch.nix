{ inputs, system, ... }: 
let
  pkgs = import inputs.nixpkgs-unstable { inherit system; config.allowUnfree = true; };
in
{
  environment.systemPackages = with pkgs; [
    retroarchFull
    retroarch-joypad-autoconfig
    retroarch-assets
  ];
}
