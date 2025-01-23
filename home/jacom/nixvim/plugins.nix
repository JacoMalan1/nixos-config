{ ... }: {
  programs.nixvim = {
    plugins = {
      gitsigns.enable = true;
      rustaceanvim.enable = true;
      lspkind = {
        enable = true;
        cmp.enable = true;
      };
      notify.enable = true;
      fidget = {
        enable = true;
        settings.progress.display.done_ttl = 1;
      };
      aerial = { enable = true; };
      dropbar = {
        enable = true;
        settings = { icons.ui.bar = { separator = " > "; }; };
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
        enableLspFormat = false;
        sources = {
          formatting = {
            nixfmt.enable = true;
            prettierd = {
              enable = true;
              disableTsServerFormatter = true;
            };
          };
        };
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
            "<S-Tab>" =
              "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
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
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          angularls.enable = true;
          cssls.enable = true;
          eslint.enable = true;
          ts_ls.enable = true;
          yamlls.enable = true;
          tailwindcss.enable = true;
          html.enable = true;
        };
      };
      web-devicons.enable = true;
      bufferline = {
        enable = true;
        settings.options = {
          offsets = [{
            filetype = "NvimTree";
            text = "File Explorer";
            highlight = "Directory";
            padding = 1;
          }];
        };
      };
      treesitter = {
        enable = true;
        settings.indent.enable = true;
        settings.highlight.enable = true;
      };
    };
  };
}
