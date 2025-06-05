{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  imports = [ ./keymaps.nix ./plugins ./dap.nix ];

  programs.nixvim = {
    enable = true;

    # autoCmd = [{
    #   command = "lua vim.lsp.buf.format()";
    #   event = "BufWritePre";
    # }];

    extraPlugins =
      [ pkgs.vimPlugins.nvim-ts-autotag pkgs.vimPlugins.onedarkpro-nvim ];

    extraConfigLua = ''
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        }
      })

      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          vim.highlight.on_yank()
        end,
      })
    '';

    colorschemes = {
      catppuccin = {
        enable = false;
        settings.flavour = "macchiato";
      };
      gruvbox.enable = true;
      dracula.enable = false;
      tokyonight.enable = false;
      onedark = {
        enable = false;
        settings.style = "warmer";
      };
    };

    globals.mapleader = " ";

    files = {
      "after/ftplugin/java.lua" = { opts = { tabstop = 2; }; };
      "after/ftplugin/typescriptreact.lua" = { opts = { tabstop = 2; }; };
      "after/ftplugin/cs.lua" = { opts = { tabstop = 4; }; };
    };

    opts = {
      relativenumber = true;
      number = true;
      wrap = false;
      shiftwidth = 2;
      signcolumn = "yes:1";
      showmode = false;
    };
  };
}
