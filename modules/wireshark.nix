{ ... }: {
  programs.wireshark.enable = true;
  users.users.jacom.extraGroups = [ "wireshark" ];
}
