{ pkgs, ... }:
{
  home.packages = with pkgs; [ claude-code ];
  programs.nixvim.plugins.claudecode.enable = true;
}
