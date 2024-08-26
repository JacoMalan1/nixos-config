{ ... }: {
  services.syncthing = {
    enable = true;
    user = "jacom";
    dataDir = "/home/jacom/Sync";
    configDir = "/home/jacom/.config/syncthing";
  };
}
