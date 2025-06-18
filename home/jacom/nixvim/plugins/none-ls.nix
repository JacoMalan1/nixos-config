{ ... }: {
  programs.nixvim.plugins.none-ls = {
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
}
