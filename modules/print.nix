{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprintBin cnijfilter2 ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    saned.enable = true;
  };

  environment.systemPackages = with pkgs; [
    system-config-printer
    skanlite
    simple-scan
  ];

  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [ sane-airscan ];
  };
  users.users."jacom".extraGroups = [ "scanner" "lp" ];
}
