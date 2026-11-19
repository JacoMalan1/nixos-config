{ pkgs, ... }:
{
  imports = [
    ./nixvim
    ./tmux.nix
    ./zsh.nix
  ];

  home.username = "jacom";
  home.homeDirectory = "/home/jacom";

  home.packages = with pkgs; [
    direnv
    zoxide
    fzf
  ];

  services.ssh-agent.enable = true;

  home.stateVersion = "25.05";
}
