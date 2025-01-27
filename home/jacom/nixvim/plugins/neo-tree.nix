{ ... }: {
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true;
    window.autoExpandWidth = true;
    defaultComponentConfigs = {
      modified.symbol = "";
      gitStatus.symbols = {
        added = "+";
        modified = "M";
        unstaged = "*";
        staged = "+";
        untracked = "?";
        renamed = "R";
        ignored = "◌";
      };
    };
  };
}
