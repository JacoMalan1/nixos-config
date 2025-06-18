{ ... }: {
  programs.nixvim.plugins.jdtls = {
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
}
