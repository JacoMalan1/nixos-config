{ ... }: {
  programs.nixvim.plugins = {
    dap-ui = {
      enable = true;
      settings.floating.mappings = { close = [ "<ESC>" "q" ]; };
    };
    dap = {
      enable = true;
      adapters.executables = {
        gdb = {
          command = "gdb";
          args = [ "--interpreter=dap" "--eval-command" "set print pretty on" ];
        };
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
}
