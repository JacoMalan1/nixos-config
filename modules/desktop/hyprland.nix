{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    portalPackage = pkgs.unstable.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  programs.hyprlock = {
    enable = true;
    package = pkgs.unstable.hyprlock;
  };

  security.pam.services.hyprlock = {
    text = ''
      account required pam_unix.so
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth sufficient ${pkgs.unstable.pam_u2f}/lib/security/pam_u2f.so pinverification=1
      auth required pam_deny.so
      password sufficient pam_unix.so nullok yescrypt
      session required pam_env.so conffile=/etc/pam/environment readenv=0
      session required pam_unix.so
    '';
  };

  environment.systemPackages = with pkgs.unstable; [
    rofi
    wl-clipboard
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
