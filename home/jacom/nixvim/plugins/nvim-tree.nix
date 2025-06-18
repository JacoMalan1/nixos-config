{ ... }: {
  programs.nixvim.plugins.nvim-tree = {
    enable = true;
    autoClose = true;
    renderer.highlightGit = true;
    view.width = {
      min = 30;
      max = -1;
    };
    diagnostics = {
      enable = true;
      showOnDirs = true;
    };
  };
}
