{ ... }: {
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    settings = {
      auto_clean_after_session_restore = true;
      close_if_last_window = true;
      window = {
      mappings = {
	  "]b" = "next_source";
	  "[b" = "prev_source";
	};
      };
      filesystem.follow_current_file.enabled = true;
      source_selector.winbar = true;
      default_component_configs = {
	modified.symbol = "";
	diagnostics.symbols = {
	  error = "";
	  hint = "";
	  info = "";
	  warn = "";
	};
	git_status.symbols = {
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
