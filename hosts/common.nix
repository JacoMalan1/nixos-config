{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  time.timeZone = "Africa/Johannesburg";
  i18n.defaultLocale = "en_ZA.UTF-8";

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.pkgs.zsh;

  programs.nh = { enable = true; };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [ ];

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs-stable;
    [
      inputs.agenix.packages.${system}.default transmission_4-gtk
      glib
      glib.dev
      gsettings-desktop-schemas
      smartmontools
      man-pages
      man-pages-posix
      yubikey-manager
      speedtest-cli
      doxygen
      valgrind
      gdb
      lldb
      eog
      libreoffice-fresh
      yasm
      jq
      dig
      whois
      tor-browser
      qalculate-gtk
      sshfs
      hunspell
      hunspellDicts.en_GB-ise
      awscli2
      google-cloud-sdk
      nmap
      zoxide
      openscad
      chromium
      libnotify
      fd
      playerctl
      wireguard-tools
      kdePackages.kleopatra
      figma-linux
      networkmanagerapplet
      tmux
      github-cli
      pavucontrol
    ] ++ (with pkgs; [ clang novelwriter postman element-desktop ]);

  environment.sessionVariables = {
    FLAKE = "$HOME/nix";
    NH_FLAKE = "$HOME/nix";
    CARGO_TARGET_DIR = "$HOME/.cargo-target";
  };

  services.gvfs.enable = true;
  services.smartd.enable = true;
  services.pcscd.enable = true;
}
