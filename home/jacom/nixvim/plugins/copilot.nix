{ inputs, system, ... }: {
  programs.nixvim.plugins = {
    copilot-chat = {
      enable = true;
    };
  };
}
