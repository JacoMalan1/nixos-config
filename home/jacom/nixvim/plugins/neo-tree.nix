{ ... }: {
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    settings = {
      autoCleanAfterSessionRestore = true;
      closeIfLastWindow = true;
      window = {
      mappings = {
	  "]b" = "next_source";
	  "[b" = "prev_source";
	};
      };
      filesystem.followCurrentFile.enabled = true;
      sourceSelector.winbar = true;
      defaultComponentConfigs = {
	modified.symbol = "";
	diagnostics.symbols = {
	  error = "";
	  hint = "";
	  info = "";
	  warn = "";
	};
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
  };
}
