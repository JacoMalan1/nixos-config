{ config, pkgs, ... }:

{
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
  ];

  gtk.enable = true;
  
  home.pointerCursor.gtk.enable = true;
  home.pointerCursor.x11.enable = true;
  home.pointerCursor.package = pkgs.kdePackages.breeze;
  home.pointerCursor.name = "Breeze_Light";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/Breeze_Light";
    ".local/share/icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/Breeze_Light";
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
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";

    initExtra = "source ~/.p10k.zsh\nbindkey -M viins 'jj' vi-cmd-mode";

    shellAliases = {
      ls = "eza";
      cat = "bat";
    };

    plugins = [
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
  };

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "Mod1";
    bind = [
      "$mod, B, exec, librewolf"
      "SUPER, Q, exec, kitty"
    ];
    monitor = [
      "HDMI-A-1, 1920x1080, 0x0, 1"
      "HDMI-A-2, 1920x1080, 1920x0, 1"
      "Unknown-1, disable"
    ];
    env = [
      "AQ_ARM_DEVICES,/dev/dri/card1:/dev/dri/card2"
      "LIBVA_DRIVER_NAME,nvidia"
      "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
      "GDK_BACKEND,wayland,x11"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "WLR_RENDERER,vulkan"
    ];

    cursor.no_hardware_cursors = true;
  };
}
