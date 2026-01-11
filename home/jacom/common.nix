{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  imports = [ ./tmux.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jacom";
  home.homeDirectory = "/home/jacom";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    zsh-powerlevel10k
    meslo-lgs-nf
    gcr
    seahorse
    networkmanagerapplet
    gnome-icon-theme
    hicolor-icon-theme
    fzf
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 13.0;
    };
    settings = {
      enable_audio_bell = false;
      shell = "tmux";
      background_opacity = "0.7";
      # cursor_trail = 32;
      # cursor_trail_decay = "0.1 0.2";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };

    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = true
    '';
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/leftwm/config.ron".source = ./leftwm.ron;
    ".config/waybar/style.css".source = ./waybar/style_gruvbox.css;
    ".config/waybar/macchiato.css".source = ./waybar/macchiato.css;
    ".config/waybar/gruvbox.css".source = ./waybar/gruvbox.css;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jacom/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { };

  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.lazygit = {
    enable = true;
    settings = { git.autoFetch = false; };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";

    initContent = ''
      export PATH=$PATH:$HOME/.cargo/bin
      export PATH=$PATH:$HOME/go/bin
      export PATH=$PATH:$HOME/.npm-global/bin
      export PATH=$PATH:$HOME/bin
      export PATH=$PATH:$HOME/.local/bin
      export PATH=$PATH:$HOME/.yarn/bin
      export EDITOR=nvim
      source ~/.p10k.zsh
      bindkey -M viins 'jj' vi-cmd-mode
      eval "$(direnv hook zsh)"
      eval "$(zoxide init --cmd cd zsh)"
      eval "$(fzf --zsh)"

      if [ $TTY = '/dev/tty1' ]; then start-hyprland; fi

      if [ -d $HOME/bin ]; then
      	export PATH=$PATH:$HOME/bin
      fi
    '';

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      cat = "${pkgs.bat}/bin/bat";
      nx = "${pkgs.yarn}/bin/yarn nx";
      ns = "nix-shell --command zsh -p";
    };

    plugins = [{
      name = "zsh-powerlevel10k";
      src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
      file = "powerlevel10k.zsh-theme";
    }];
  };

  services.wlsunset = {
    enable = true;
    latitude = -29.0;
    longitude = 24.0;
    temperature.night = 3400;
  };

  services.gnome-keyring.enable = true;
  services.blueman-applet.enable = true;

  xdg.systemDirs.data = [ "${pkgs.networkmanagerapplet}/share" ];
  services.network-manager-applet.enable = true;
}
