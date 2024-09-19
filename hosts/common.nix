{ inputs, system, ... }: 
  let
    pkgs = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
    pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  in
  {
    time.timeZone = "Africa/Johannesburg";
    i18n.defaultLocale = "en_ZA.UTF-8";
    
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.pkgs.zsh;

    programs.nh = {
      enable = true;
    };

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs-stable; [
      transmission-gtk
      glib
      glib.dev
      gsettings-desktop-schemas
      smartmontools
      man-pages
      man-pages-posix
      yubikey-manager
      speedtest-cli
    ];

    environment.sessionVariables = {
      FLAKE = "$HOME/nix";
      CARGO_TARGET_DIR = "$HOME/.cargo-target";
    };

    services.gvfs.enable = true;
    services.smartd.enable = true;
    services.pcscd.enable = true;
  }
