{ lib, config, inputs, system, ... }:
let pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  options.custom.tmux = { enable = lib.mkEnableOption "Enable TMUX mnodule"; };

  config = let cfg = config.custom.tmux;
  in lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      package = pkgs.tmux;
      keyMode = "vi";
      mouse = true;
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.gruvbox;
          extraConfig = "set -g @tmux-gruvbox 'dark'";
        }
        tmuxPlugins.sensible
      ];
    };
  };
}
