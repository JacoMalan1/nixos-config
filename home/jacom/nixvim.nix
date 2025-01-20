{ inputs, system, ... }: 
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
in
{
  programs.nixvim = {
    enable = true;

    extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
      name = "nx.nvim";
      src = pkgs.fetchFromGitHub {
	owner = "Equilibris";
	repo = "nx.nvim";
	rev = "f8a3a21b3d540889401a40d1f2803083794c0372";
	hash = "sha256-Yl7tg466650w4CZcuFdnUZhXk6z/uq0AHa64EKeZx/o=";
      };
    })];

    extraConfigLuaPost = ''
      require("nx").setup({
	nx_cmd_root = "yarn nx",
	read_init = true,
      })
    '';

    colorschemes = {
      catppuccin = {
	enable = false;
	settings.flavour = "macchiato";
      };
      gruvbox = {
	enable = true;
      };
    };

    globals.mapleader = " ";

    opts = {
      relativenumber = true;
      number = true;
      wrap = false;
      shiftwidth = 2;
      signcolumn = "yes:1";
    };

    keymaps = [
      {
	mode = [ "i" ];
	key = "jj";
	action = "<Esc>";
      }
      {
	mode = [ "n" ];
	key = "<leader>w";
	action = "<Cmd>w<CR>";
	options.desc = "Write buffer";
      }
      {
	mode = [ "n" ];
	key = "<leader>e";
	action = "<Cmd>NvimTreeToggle<CR>";
      }
      {
	mode = [ "n" ];
	key = "<C-h>";
	action = "<C-w>h";
      }
      {
	mode = [ "n" ];
	key = "<C-l>";
	action = "<C-w>l";
      }
      {
	mode = [ "n" ];
	key = "<C-j>";
	action = "<C-w>j";
      }
      {
	mode = [ "n" ];
	key = "<C-k>";
	action = "<C-w>k";
      }
      {
	mode = [ "n" ];
	key = "<leader>fw";
	action = "<Cmd>Telescope live_grep<CR>";
      }
      {
	mode = [ "n" ];
	key = "<leader>gg";
	action = "<Cmd>LazyGit<CR>";
      }
      {
	mode = [ "n" ];
	key = "<leader>/";
	action = "gcc";
      }
      {
	mode = [ "v" ];
	key = "<leader>/";
	action = "gc";
      }
      {
	mode = [ "n" ];
	key = "<leader>nx";
	action = "<Cmd>Telescope nx actions<CR>";
	options.desc = "Nx actions";
      }
      {
	mode = [ "n" ];
	key = "<leader>lS";
	action = "<Cmd>AerialToggle<CR>";
	options.desc = "Symbols Overview";
      }
      {
	mode = [ "n" ];
	key = "<leader>la";
	action = "<Cmd>lua vim.lsp.buf.code_action()<CR>";
	options.desc = "LSP Code Action";
      }
      {
	mode = [ "n" ];
	key = "<leader>ld";
	action = "<Cmd>lua vim.diagnostic.open_float()<CR>";
	options.desc = "LSP Floating Diagnostics";
      }
      {
	mode = [ "n" ];
	key = "<leader>lr";
	action = "<Cmd>lua vim.lsp.buf.rename()<CR>";
	options.desc = "LSP Rename Symbol";
      }
      {
	mode = [ "n" ];
	key = "]b";
	action = "<Cmd>bnext<CR>";
      }
      {
	mode = [ "n" ];
	key = "[b";
	action = "<Cmd>bprev<CR>";
      }
      {
	mode = [ "n" ];
	key = "<leader>c";
	action = "<Cmd>bp<CR><Cmd>bd#<CR>";
	options.desc = "Close current buffer";
      }
    ];

    plugins = {
      notify.enable = true;
      fidget = {
	enable = true;
	settings.progress.display.done_ttl = 1;
      };
      aerial = {
	enable = true;
      };
      dropbar = {
	enable = true;
	settings = {
	  icons.ui.bar = {
	    separator = " > ";
	  };
	};
      };
      nvim-autopairs.enable = true;
      lualine = {
	enable = true;
	settings.options = {
	  disabled_filetypes = [ "NvimTree" ];
	  globalstatus = true;
	};
      };
      luasnip.enable = true;
      none-ls = {
	enable = true;
	enableLspFormat = true;
      };
      lazygit.enable = true;
      cmp = {
	enable = true;
	autoEnableSources = true;
	settings = {
	  sources = [
	    { name = "nvim_lsp"; }
	    { name = "luasnip"; }
	    { name = "buffer"; }
	    { name = "path"; }
	  ];
	  mapping = {
	    "<C-Space>" = "cmp.mapping.complete()";
	    "<C-k>" = "cmp.mapping.scroll_docs(-4)";
	    "<C-j>" = "cmp.mapping.scroll_docs(4)";
	    "<CR>" = "cmp.mapping.confirm({ select = true })";
	    "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
	    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
	  };
	};
      };
      telescope.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      which-key.enable = true;
      nvim-tree = {
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
      lsp-format.enable = true;
      lsp = {
	enable = true;
	servers = {
	  nil_ls.enable = true;
	  rust_analyzer = {
	    enable = true;
	    installCargo = false;
	    installRustc = false;
	  };
	  angularls.enable = true;
	  cssls.enable = true;
	  eslint.enable = true;
	  ts_ls.enable = true;
	  yamlls.enable = true;
	};
      };
      web-devicons.enable = true;
      bufferline = {
	enable = true;
	settings.options = {
	  offsets = [
	    {
	      filetype = "NvimTree";
	      text = "File Explorer";
	      highlight = "Directory";
	      padding = 1;
	    }
	  ];
	};
      };
      treesitter = {
	enable = true;
	settings.indent.enable = true;
	settings.highlight.enable = true;
      };
      dap = {
	enable = true;
	extensions = {
	  dap-ui = {
	    enable = true;
	    floating.mappings = {
	      close = [
		"<ESC>" 
		"q"
	      ];
	    };
	  };
	};
	adapters.executables = {
	  gdb = {
	    command = "gdb";
	    args = [
	      "--interpreter=dap" 
	      "--eval-command"
	      "set print pretty on" 
	    ];
	  };
	};
	configurations = {
	  rust = [
	    {
	      name = "Launch (gdb)";
	      type = "gdb";
	      request = "launch";
	      program = ''
		function()
		  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end
	      '';
	      stopAtBeginningOfMainSubprogram = true;
	    }
	  ];
	};
      };
    };
  };
}
