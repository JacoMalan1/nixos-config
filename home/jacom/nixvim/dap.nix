{ ... }: {
  programs.nixvim.plugins.dap = {
    enable = true;
    extensions = {
      dap-ui = {
        enable = true;
        floating.mappings = { close = [ "<ESC>" "q" ]; };
      };
    };
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
}
