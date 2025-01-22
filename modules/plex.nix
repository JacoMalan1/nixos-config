{ ... }: {
  services.plex = {
    enable = true;
    openFirewall = true;
    user = "jacom";
  };
}
