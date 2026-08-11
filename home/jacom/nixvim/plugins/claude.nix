{ inputs, system, ... }: 
let 
  pkgs = import inputs.nixpkgs-unstable { inherit system; config.allowUnfree = true; };
in {
  home.packages = with pkgs; [ claude-code ];
  programs.nixvim.plugins.claudecode.enable = true;
}
