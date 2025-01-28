{ ... }: {
  programs.nixvim = {
    files = {
      "after/ftplugin/rust.lua" = {
        keymaps = [
          {
            mode = [ "n" ];
            key = "K";
            action = "<Cmd>lua vim.cmd.RustLsp({'hover', 'actions'})<CR>";
            options = {
              silent = true;
              buffer = true;
              desc = "Rust LSP hover";
            };
          }
          {
            mode = [ "n" ];
            key = "<leader>la";
            action = "<Cmd>lua vim.cmd.RustLsp('codeAction')<CR>";
            options = {
              silent = true;
              buffer = true;
              desc = "Rust LSP Code Actions";
            };
          }
        ];
      };
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
        action = "<Cmd>Neotree toggle<CR>";
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
        key = "<leader>gl";
        action = "<Cmd>Gitsigns blame_line<CR>";
        options.desc = "Git blame (line)";
      }
      {
        mode = [ "n" ];
        key = "<leader>gL";
        action = "<Cmd>Gitsigns blame<CR>";
        options.desc = "Git full blame";
      }
      {
        mode = [ "n" ];
        key = "<leader>gs";
        action = "<Cmd>Gitsigns stage_hunk<CR>";
        options.desc = "Git stage hunk";
      }
      {
        mode = [ "n" ];
        key = "<leader>gS";
        action = "<Cmd>Gitsigns undo_stage_hunk<CR>";
        options.desc = "Git unstage hunk";
      }
      {
        mode = [ "n" ];
        key = "<leader>gr";
        action = "<Cmd>Gitsigns reset_hunk<CR>";
        options.desc = "Git reset hunk";
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
  };
}
