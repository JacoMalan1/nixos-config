{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
in {
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  programs.hyprlock = {
    enable = true;
    package = pkgs-unstable.hyprlock;
  };

  security.pam.services.hyprlock = {
    text = ''
      account required pam_unix.so
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth sufficient ${pkgs.pam_u2f}/lib/security/pam_u2f.so pinverification=1
      auth required pam_deny.so
      password sufficient pam_unix.so nullok yescrypt
      session required pam_env.so conffile=/etc/pam/environment readenv=0
      session required pam_unix.so
    '';
  };

  environment.systemPackages = with pkgs;
    [ waybar swww rofi-wayland wl-clipboard ]
    ++ (with pkgs-unstable; [ hyprpaper ]);

  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };
}
