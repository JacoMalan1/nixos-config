{ ... }: {
  home.file = {
    ".config/rofi/config.rasi".text = ''
      @theme "/home/jacom/.local/share/rofi/themes/rounded-gruvbox.rasi"
    '';
    ".local/share/rofi/themes/rounded-gruvbox.rasi".text = ''
      * {
	  bg0:    #212121F2;
	  bg1:    #2A2A2A;
	  bg2:    #3D3D3D80;
	  bg3:    #98971AF2;
	  fg0:    #E6E6E6;
	  fg1:    #FFFFFF;
	  fg2:    #969696;
	  fg3:    #3D3D3D;
      }

      @import "rounded-common.rasi"
    '';
    ".local/share/rofi/themes/rounded-common.rasi".source = ./rounded-common.rasi;
  };
}
