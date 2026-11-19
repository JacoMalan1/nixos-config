{ ... }: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "jacom";
    dataDir = "/home/jacom/Sync";
    configDir = "/home/jacom/.config/syncthing";
  };
}
