{ inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  environment.systemPackages = with pkgs;
    [
      zsh
      keepassxc
      zsh-powerlevel10k
      zsh-autosuggestions
      git
      eza
      bat
      dust
      discord
      pciutils
      usbutils
      lazygit
      gcc_multi
      rustup
      easyeffects
      psmisc
      xorg.xkill
      lshw
      glxinfo
      cmake
      gnumake
      pam_u2f
      xss-lock
      gnupg
      macchanger
      scrot

      # GNOME utilities
      nautilus
      gnome-disk-utility
      evince

      yarn

      neofetch
      onefetch
      btop
      kitty
      zellij
      brave
      leftwm
      librewolf

      direnv
      nix-direnv
      fzf
      ripgrep
      mesa

      python3
      unzip

      brightnessctl
      exfat
      dolphin-emu
      wiimms-iso-tools
      ntfs3g
      thunderbird
      vlc
      gparted
      steam-run
      unrar
      p7zip
      stremio
      android-tools
      rpi-imager
      gcc-arm-embedded
      hyprpolkitagent
      vscode-fhs
      dbeaver-bin
      icu
      maven
      pwvucontrol
      drawio
      slurp
      teams-for-linux
      obsidian
      yubikey-personalization-gui
      yubioath-flutter
      android-studio
      lm_sensors
      dotnet-sdk_8
      inkscape
      gnome-icon-theme
      hicolor-icon-theme
      wireguard-ui
      xmrig
      inputs.strain.defaultPackage.${system}
    ] ++ (with pkgs-unstable; [
      jetbrains.idea-community-bin
      nodejs_20
      spotify
      monero-gui
      monero-cli
      signal-desktop
    ]);
}
