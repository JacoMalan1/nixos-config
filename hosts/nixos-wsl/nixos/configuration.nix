{ inputs, system, lib, ... }: 
let
  pkgs = import inputs.nixpkgs-unstable { inherit system; };
in {
  wsl.enable = true;
  wsl.defaultUser = "jacom";
  wsl.usbip = {
    enable = true;
    autoAttach = [
      "2-6"
    ];
  };
  wsl.wslConf.network.hostname = "nixos-wsl";

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gtk2;

  systemd.services.load-kernel-modules = {
    description = "Load additional kernel modules";
    after = [ "basic.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/sbin/modprobe vhci_hcd";
      User = "root";
    };

    wantedBy = [ "multi-user.target" ];
  };

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0664", GROUP="users", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0407"
  '';
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.pcscd.enable = lib.mkForce true;
  
  environment.sessionVariables = {
    FLAKE = "$HOME/nix";
    NH_FLAKE = "$HOME/nix";
    CARGO_TARGET_DIR = "$HOME/.cargo-target";
  };

  custom.commonConfiguration = {
    enable = true;
    guiPresent = false;
    services = false;
  };

  networking.wireguard.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
    git
    monero-cli
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
