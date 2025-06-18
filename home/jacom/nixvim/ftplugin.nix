{ ... }: {
    programs.nixvim.files = {
      "after/ftplugin/java.lua" = { opts = { tabstop = 2; }; };
      "after/ftplugin/typescriptreact.lua" = { opts = { tabstop = 2; }; };
      "after/ftplugin/cs.lua" = { opts = { tabstop = 4; }; };
    };
}
