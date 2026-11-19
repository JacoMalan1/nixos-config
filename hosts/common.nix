{
  pkgs,
  inputs,
  lib,
  config,
  system,
  ...
}:
let
  cfg = config.custom.common;

  stableGuiApps = with pkgs.stable; [
    transmission_4-gtk
    qalculate-gtk
    networkmanagerapplet
    kdePackages.kleopatra
    pavucontrol
    openscad
    chromium
    yubikey-manager
    figma-linux
    mission-center
  ];
  unstableGuiApps = with pkgs.unstable; [
    novelwriter
    postman
    element-desktop
    vulkan-caps-viewer
  ];
in
{
  options.custom.common = {
    gui = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    services = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    time.timeZone = "Africa/Johannesburg";
    i18n.defaultLocale = "en_ZA.UTF-8";

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.unstable.zsh;

    programs.nh = {
      enable = true;
    };

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = [ ];

    programs.dconf.enable = true;

    environment.systemPackages =
      with pkgs.stable;
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
        tor-browser
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
        mtr
        traceroute
        zip
      ]
      ++ (with pkgs.unstable; [
        clang
        net-tools
        nix-sweep
      ])
      ++ (lib.optionals cfg.gui (stableGuiApps ++ unstableGuiApps));

    environment.sessionVariables = {
      FLAKE = "$HOME/nix";
      NH_FLAKE = "$HOME/nix";
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = lib.mkDefault true;
    };

    services.dbus.packages = [ pkgs.unstable.gcr_4 ];
    services.gvfs.enable = cfg.services;
    services.smartd.enable = cfg.services;
    services.pcscd.enable = cfg.services;
  };
}
