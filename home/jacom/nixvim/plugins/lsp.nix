{
  inputs,
  system,
  lib,
  ...
}:
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
in
{
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
      tailwindcss = {
        enable = true;
      };
      html.enable = true;
      basedpyright.enable = true;
      taplo.enable = true;
      clangd = {
        enable = true;
        settings = lib.mkForce {
          cmd = [
            "clangd"
            "--query-driver=\"*hipcc\""
            "--background-index"
          ];
          filetypes = [
            "cc"
            "c"
            "cpp"
            "hip"
          ];
          root_markers = [
            "compile_commands.json"
            "compile_flags.txt"
          ];
        };
      };
      glsl_analyzer.enable = true;
      zls.enable = true;
      cmake.enable = true;
      csharp_ls.enable = true;
      vue_ls.enable = true;
      svelte.enable = true;
      protols.enable = true;
      kotlin_language_server.enable = true;
      lua_ls.enable = true;
      texlab.enable = true;
      terraformls.enable = true;
      astro.enable = true;
    };
  };
}
