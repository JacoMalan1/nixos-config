{ inputs, system, ... }: 
let
  pkgs = import inputs.nixpkgs-stable { inherit system; config.allowUnfree = true; };
in
{
  environment.systemPackages = with pkgs; [
    neovim
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
    kdePackages.breeze
    scrot
    
    # GNOME utilities
    gnome.nautilus
    gnome.gnome-disk-utility
    evince
    
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
  ];
}
