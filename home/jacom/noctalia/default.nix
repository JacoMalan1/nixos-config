{ inputs, config, system, lib, ... }: 
let
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
  cfg = config.custom.noctalia;
in {
  options.custom.noctalia = { enable = lib.mkEnableOption "Enable noctalia shell"; };

  config = lib.mkIf cfg.enable {
    home.file.".cache/noctalia/wallpapers.json" = {
      text = builtins.toJSON {
	defaultWallpaper = "/home/jacom/nix/home/jacom/gruvbox-wallpaper.jpg";
      };
    };

    programs.noctalia-shell = {
      enable = true;
      settings = (builtins.fromJSON (builtins.readFile ./hotbox.json)).settings;
    };
  };
}
