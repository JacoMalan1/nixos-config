{ ... }: {
  programs.nixvim = {
    plugins.toggleterm.enable = true;
    keymaps = [
      {
	mode = [ "n" ];
	key = "<leader>tf";
	action = "<Cmd>ToggleTerm direction=float<CR>";
	options.desc = "Toggle floating terminal";
      }
      {
	mode = [ "n" ];
	key = "<leader>tb";
	action = "<Cmd>ToggleTerm direction=horizontal<CR>";
	options.desc = "Toggle terminal (bottom)";
      }
      {
	mode = [ "t" ];
	key = "<Esc>";
	action = "<C-\\><C-n>";
      }
    ];
  };
}
