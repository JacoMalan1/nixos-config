{ ... }: {
  programs.nixvim.plugins.blink-cmp = {
    enable = true;
    settings = {
      signature = {
	enabled = true;
	window = {
	  border = "rounded";
	  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder";
	};
      };
      completion = {
	documentation = {
	  auto_show = true;
	  auto_show_delay_ms = 0;
	  window = {
	    border = "rounded";
	    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None";
	  };
	};
	menu = {
	  border = "rounded";
	  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None";
	};
      };
      keymap = {
	preset = "enter";
	"<C-Space>" = [
	  "show"
	  "show_documentation"
	  "hide_documentation"
	];
	"<C-k>" = [
	  "scroll_documentation_up"
	  "fallback"
	];
	"<C-j>" = [
	  "scroll_documentation_down"
	  "fallback"
	];
	"<CR>" = [
	  "select_and_accept"
	  "fallback"
	];
	"<S-Tab>" = [
	  "select_prev"
	  "fallback"
	];
	"<Tab>" = [
	  "select_next"
	  "fallback"
	];
      };
    };
  };
}
