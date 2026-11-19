{ pkgs, ... }:
{
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

    plugins = [
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
  };
}
