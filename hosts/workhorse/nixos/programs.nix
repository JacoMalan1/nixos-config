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
      networkmanagerapplet
      signal-desktop
      spotify
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

      nodejs_20
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
      jdk17
      steam-run
      unrar
      p7zip
      stremio
      android-tools
      zoom-us
      rpi-imager
      gcc-arm-embedded
      hyprpolkitagent
      vscode-fhs
      dbeaver-bin
      icu
    ] ++ (with pkgs-unstable; [ jetbrains.rider ]);
}
