{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [ "dotnet-sdk-6.0.428" ];

  environment.systemPackages =
    (with pkgs; [
      zsh
      zsh-powerlevel10k
      zsh-autosuggestions
      git
      eza
      bat
      fzf
      ripgrep
      direnv
      nix-direnv
      unzip
      psmisc
      pciutils
      usbutils
      lshw
      lm_sensors
      mesa
      mesa-demos
      macchanger
      gnupg
      pam_u2f
      xss-lock
      onefetch

      cmake
      gnumake
      rustup
      python3
      yarn
      dotnet-combined

      nautilus
      gnome-disk-utility
      evince
      gparted

      keepassxc
      librewolf
      brave
      discord
      teams-for-linux
      obsidian
      inkscape
      vlc
      dbeaver-bin
      yubioath-flutter
      texlive.combined.scheme-full
      xmrig
    ])
    ++ (with pkgs.unstable; [
      lazygit
      zellij
      gcc_multi
      easyeffects
      android-studio
      android-tools
      jetbrains.rider
      prusa-slicer
      monero-gui
      monero-cli
      ledger-live-desktop
      signal-desktop
      thunderbird
      spotify
      winbox
    ]);
}
