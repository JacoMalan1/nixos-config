{ inputs, system, ... }: 
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
      angularls.enable = true;
      cssls = {
	enable = true;
	package = pkgs.csharp-ls;
      };
      eslint.enable = true;
      ts_ls.enable = true;
      yamlls.enable = true;
      tailwindcss.enable = true;
      html.enable = true;
      pylsp.enable = true;
      taplo.enable = true;
      clangd.enable = true;
      glsl_analyzer.enable = true;
      zls.enable = true;
      cmake.enable = true;
      csharp_ls.enable = true;
      volar.enable = true;
      svelte.enable = true;
    };
  };
}
