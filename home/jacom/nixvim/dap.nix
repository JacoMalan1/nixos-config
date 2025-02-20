{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  home.packages = with pkgs; [ lldb_19 ];

  programs.nixvim.extraConfigLua = ''
    require('dap').configurations.cpp = {
      {
    	name = "Launch file",
    	type = "codelldb",
    	request = "launch",
    	program = function()
    	  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    	end,
    	cwd = '\$\{workspaceFolder\}',
    	stopAtEntry = true,
      },
    }
  '';

  programs.nixvim = {
    keymaps = [
      {
        mode = [ "n" ];
        key = "<leader>dc";
        action = "<Cmd>DapContinue<CR>";
        options.desc = "Start/continue debugger";
      }
      {
        mode = [ "n" ];
        key = "<leader>dx";
        action = "<Cmd>DapTerminate<CR>";
        options.desc = "Terminate session";
      }
      {
        mode = [ "n" ];
        key = "<F10>";
        action = "<Cmd>DapStepOver<CR>";
        options.desc = "Step over (F10)";
      }
      {
        mode = [ "n" ];
        key = "<F9>";
        action = "<Cmd>DapStepInto<CR>";
        options.desc = "Step into (F9)";
      }
      {
        mode = [ "n" ];
        key = "<F9>";
        action = "<Cmd>DapStepOut<CR>";
        options.desc = "Step out (F11)";
      }
      {
        mode = [ "n" ];
        key = "<leader>db";
        action = "<Cmd>DapToggleBreakpoint<CR>";
        options.desc = "Toggle breakpoint";
      }
      {
        mode = [ "n" ];
        key = "<leader>du";
        action = "<Cmd>lua require('dapui').toggle()<CR>";
        options.desc = "Toggle debugger UI";
      }
    ];

    plugins = {
      dap-ui = {
        enable = true;
        settings.floating.mappings = { close = [ "<ESC>" "q" ]; };
      };
      dap = {
        enable = true;
        adapters.executables = {
          gdb = {
            command = "gdb";
            args =
              [ "--interpreter=dap" "--eval-command" "set print pretty on" ];
          };
          codelldb = { command = "${pkgs.lldb_19}/bin/lldb-dap"; };
        };
        configurations = {
          rust = [{
            name = "Launch (gdb)";
            type = "gdb";
            request = "launch";
            program =
              "\n      function()\n	return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')\n      end\n    ";
            stopAtBeginningOfMainSubprogram = true;
          }];
        };
      };
    };
  };
}
