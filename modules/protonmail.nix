{ inputs, system, ... }: 
let 
  pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  services.protonmail-bridge = {
    enable = true;
    path = with pkgs; [
      pass
      gnome-keyring
    ];
  };
}
