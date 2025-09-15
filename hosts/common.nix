{ inputs, lib, config, system, ... }:
let
  pkgs = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
  cfg = config.custom.commonConfiguration;

  stableGuiApps = with pkgs; [
    transmission_4-gtk
    qalculate-gtk
    networkmanagerapplet
    kdePackages.kleopatra
    pavucontrol
    openscad
    chromium
    yubikey-manager
    figma-linux
  ];
  unstableGuiApps = with pkgs; [ novelwriter postman element-desktop ];
in {
  options.custom.commonConfiguration = {
    enable = lib.mkEnableOption "Enable common configuration options";

    guiPresent = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    services = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
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
        inputs.agenix.packages.${system}.default
        glib
        glib.dev
        gsettings-desktop-schemas
        smartmontools
        man-pages
        man-pages-posix
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
        tor-browser-bundle-bin
        sshfs
        hunspell
        hunspellDicts.en_GB-ise
        awscli2
        google-cloud-sdk
        nmap
        zoxide
        libnotify
        fd
        playerctl
        wireguard-tools
        tmux
        github-cli
	gnupg
      ] ++ (with pkgs; [ clang net-tools ])
      ++ (lib.optionals cfg.guiPresent (stableGuiApps ++ unstableGuiApps));

    environment.sessionVariables = {
      FLAKE = "$HOME/nix";
      NH_FLAKE = "$HOME/nix";
      CARGO_TARGET_DIR = "$HOME/.cargo-target";
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    services.dbus.packages = [ pkgs.gcr ];
    services.gvfs.enable = cfg.services;
    services.smartd.enable = cfg.services;
    services.pcscd.enable = cfg.services;
  };
}
