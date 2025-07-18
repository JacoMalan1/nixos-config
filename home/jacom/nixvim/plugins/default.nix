{ ... }: {
  imports = [
    ./neo-tree.nix
    ./cmp.nix
    ./lsp.nix
    ./jdtls.nix
    ./none-ls.nix
    ./toggleterm.nix
  ];

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
      lazygit.enable = true;
      telescope.enable = true;
      which-key.enable = true;
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
      toggleterm.enable = true;
      todo-comments.enable = true;
      trouble.enable = true;
    };
  };
}
