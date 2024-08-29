{ inputs, ... }: 
  let
    pkgs = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
  in
  {
    time.timeZone = "Africa/Johannesburg";
    i18n.defaultLocale = "en_ZA.UTF-8";
    
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.pkgs.zsh;

    programs.nh = {
      enable = true;
    };

    environment.sessionVariables = {
      FLAKE = "$HOME/nix";
    };
  }
