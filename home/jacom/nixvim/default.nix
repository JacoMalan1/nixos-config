{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  imports = [ ./keymaps.nix ./plugins ./dap.nix ];

  programs.nixvim = {
    enable = true;

    autoCmd = [{
      command = "lua vim.lsp.buf.format()";
      event = "BufWritePre";
    }];

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "nx.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "Equilibris";
          repo = "nx.nvim";
          rev = "f8a3a21b3d540889401a40d1f2803083794c0372";
          hash = "sha256-Yl7tg466650w4CZcuFdnUZhXk6z/uq0AHa64EKeZx/o=";
        };
      })
      pkgs.vimPlugins.nvim-ts-autotag
      pkgs.vimPlugins.onedarkpro-nvim
    ];

    extraConfigLua = ''
      require("nx").setup({
        nx_cmd_root = "yarn nx",
        read_init = true,
      })

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
        enable = true;
        settings.flavour = "macchiato";
      };
      gruvbox.enable = false;
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
    };

    opts = {
      relativenumber = true;
      number = true;
      wrap = false;
      shiftwidth = 2;
      signcolumn = "yes:1";
    };
  };
}
