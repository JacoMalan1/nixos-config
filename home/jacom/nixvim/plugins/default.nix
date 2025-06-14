{ ... }: {
  imports = [ ./neo-tree.nix ./cmp.nix ./lsp.nix ];

  programs.nixvim = {
    plugins = {
      colorizer.enable = true;
      persistence.enable = true;
      tailwind-tools.enable = true;
      # java = {
      #   enable = true;
      #   package = pkgs.vimPlugins.nvim-java;
      # };
      comment = {
        enable = true;
        settings = {
          opleader.line = "<leader>/";
          toggler.line = "<leader>/";
        };
      };
      jdtls = {
        enable = true;
        settings = {
          cmd = [ "jdtls" ];
          root_dir = {
            __raw =
              "  vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])\n";
          };
          init_options.settings.java.imports.gradle = {
            enabled = true;
            wrapper = {
              enabled = true;
              checksums = [{
                sha256 =
                  "81a82aaea5abcc8ff68b3dfcb58b3c3c429378efd98e7433460610fecd7ae45f";
                allowed = true;
              }];
            };
          };
        };
      };
      gitsigns.enable = true;
      rustaceanvim.enable = true;
      lspkind = {
        enable = true;
        cmp.enable = true;
      };
      notify = {
        enable = true;
        settings.level = "warn";
      };
      fidget = {
        enable = true;
        settings = { progress.display.done_ttl = 1; };
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
      telescope.enable = true;
      which-key.enable = true;
      nvim-tree = {
        enable = false;
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
      web-devicons.enable = true;
      bufferline = {
        enable = true;
        settings.options = {
          offsets = [{
            filetype = "neo-tree";
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
      neoscroll.enable = true;
    };
  };
}
