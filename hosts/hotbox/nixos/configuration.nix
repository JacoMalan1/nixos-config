{
  config,
  inputs,
  system,
  lib,
  ...
}:
let
  pkgs = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
in
{
  imports = [ ./hardware-configuration.nix ];

  custom.commonConfiguration.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  boot.blacklistedKernelModules = [ "k10temp" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];

  boot.kernelPackages = pkgs-unstable.linuxPackages_zen;
  boot.kernelModules = [ "zenpower" ];
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 1048576;
  boot.kernelParams = [ "video=DP-2:e" "threadirqs" "pcie_aspm=off" ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "hotbox"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  networking.wireguard.enable = true;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.usb-modeswitch.enable = true;
  hardware.ledger.enable = true;

  services.acpid.enable = true;

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  services.gnome.gnome-keyring.enable = true;

  services.fwupd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    input = {
      General = {
        ClassicBondedOnly = false;
      };
    };
    settings = {
      General = {
        ControllerMode = "bredr";
      };
    };
  };
  services.blueman.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.unprivilegedUsernsClone = true;

  # Grant the audio group direct realtime scheduling permission. Without this,
  # PipeWire falls back to requesting RT via rtkit/xdg-desktop-portal, which on
  # this system fails ("Could not get pidns for pid ...: Not a directory"),
  # leaving the audio threads with no realtime priority at all and causing
  # crackling regardless of buffer/quantum size.
  security.pam.loginLimits = [
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "95"; }
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "nice"; type = "-"; value = "-19"; }
  ];

  services.pipewire = {
    enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire."99-large-quantum" = {
      # Note: Audio latency = 1000 * quantum / sample_rate
      # The real crackling fix is the RT scheduling permission above. 64 was
      # empirically tested clean under 16-core 100% stress-ng load (32 caused
      # xruns in EasyEffects' own DSP chain, a compute limit not a scheduling
      # one); max-quantum stays high as a safety ceiling for heavier chains.

      "context.properties" = {
	"default.clock.rate" = 44100;
	"default.clock.allowed-rates" = [ 44100 48000 ];
	"default.clock.quantum" = 64; # ~1.3ms @ 48kHz
	"default.clock.min-quantum" = 64; # ~1.3ms @ 48kHz
	"default.clock.max-quantum" = 2048; # ~43ms @ 48kHz
      };
    };
  };

  users.groups.plugdev = { };

  users.users.jacom = {
    isNormalUser = true;
    description = "Jaco Malan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
      "plugdev"
      "adbusers"
      "gamemode"
      "audio"
    ];
    packages = with pkgs; [
      kitty
    ];
  };

  programs.firefox.enable = true;

  # NixOS Dynamically linked binaries fix
  programs.nix-ld = {
    enable = true;
    libraries = (with pkgs; [
      libspatialite
      libxml2
      freetype
      fontconfig
      icu
      nss
      nspr
      stdenv.cc.cc.lib
    ]) ++ (with pkgs-unstable; [ lightgbm ]);
  };

  # specialisation.gnome.configuration = {
  #   services.xserver = {
  #     enable = true;
  #     displayManager.gdm.enable = true;
  #     desktopManager.gnome.enable = true;
  #   };
  # };

  programs.ssh.startAgent = false;

  programs.wireshark.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = true;
    };
  };

  networking.firewall.enable = true;

  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"
    '';
  };

  # Open ports in the firewall.
  networking.firewall = {
    logRefusedPackets = true;
    logRefusedConnections = true;
    logReversePathDrops = true;
    checkReversePath = "loose";
    allowedTCPPorts = [
      8384
      22000
      25565
      22
      27017
      18080
      18089
      18084
      4200
      18189
      18141
      5900
      8766
    ];
    allowedUDPPorts = [
      22000
      21027
      27017
      18080
      51821
      18189
      18141
      5900
      8766
    ];
  };

  # Do not remove
  system.stateVersion = "24.05";

  services.tor = {
    enable = pkgs.lib.mkForce true;
    client.enable = pkgs.lib.mkForce true;
  };

  services.resolved.enable = true;
  services.flatpak.enable = true;

  # age.secrets.monero-mining-address = {
  #   file = ../../../secrets/monero-mining-address.age;
  #   owner = "p2pool";
  #   group = "p2pool";
  # };

  # services.p2pool = {
  #   enable = true;
  #   walletAddress = "$WALLET_ADDRESS";
  #   environmentFile = config.age.secrets.monero-mining-address.path;
  #   sidechain = "mini";
  #   package = pkgs.p2pool;
  #   mergeMining = {
  #     enable = true;
  #     walletAddress = "$TARI_WALLET_ADDRESS";
  #     nodeAddress = "tari://127.0.0.1:18102";
  #   };
  # };

  systemd.settings.Manager = {
    DefaultLimitNOFILE = lib.mkForce 1048576;
  };
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  programs.netextender.enable = true;

  services.tuned.enable = true;
  services.upower.enable = true;
}
