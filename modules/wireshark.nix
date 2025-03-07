{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  programs.wireshark.enable = true;
  users.users.jacom.extraGroups = [ "wireshark" ];

  environment.systemPackages = with pkgs; [ wireshark-qt ];
}
