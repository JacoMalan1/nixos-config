{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprintBin cnijfilter2 ];
  };

  environment.systemPackages = with pkgs; [ system-config-printer ];
}
