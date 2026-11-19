{ pkgs, lib, ... }:
{
  boot.loader.systemd-boot.consoleMode = "max";

  boot.kernelPackages = pkgs.unstable.linuxPackages_zen;
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 1048576;
  boot.kernelParams = [
    "video=DP-2:e"
    "threadirqs"
    "pcie_aspm=off"
  ];

  networking.hostName = "hotbox";

  networking.wireguard.enable = true;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  services.acpid.enable = true;

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
    };
  };

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;

  hardware.bluetooth = {
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
  security.unprivilegedUsernsClone = true;

  # Grant the audio group direct realtime scheduling permission. Without this,
  # PipeWire falls back to requesting RT via rtkit/xdg-desktop-portal, which on
  # this system fails ("Could not get pidns for pid ...: Not a directory"),
  # leaving the audio threads with no realtime priority at all and causing
  # crackling regardless of buffer/quantum size.
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "95";
    }
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "nice";
      type = "-";
      value = "-19";
    }
  ];

  services.pipewire.extraConfig.pipewire."99-large-quantum" = {
    # Note: Audio latency = 1000 * quantum / sample_rate
    # The real crackling fix is the RT scheduling permission above. 64 was
    # empirically tested clean under 16-core 100% stress-ng load (32 caused
    # xruns in EasyEffects' own DSP chain, a compute limit not a scheduling
    # one); max-quantum stays high as a safety ceiling for heavier chains.

    "context.properties" = {
      "default.clock.rate" = 44100;
      "default.clock.allowed-rates" = [
        44100
        48000
      ];
      "default.clock.quantum" = 64; # ~1.3ms @ 48kHz
      "default.clock.min-quantum" = 64; # ~1.3ms @ 48kHz
      "default.clock.max-quantum" = 2048; # ~43ms @ 48kHz
    };
  };

  users.users.jacom = {
    extraGroups = [
      "adbusers"
      "gamemode"
      "audio"
    ];
    packages = with pkgs; [
      kitty
    ];
  };

  # NixOS Dynamically linked binaries fix
  programs.nix-ld = {
    enable = true;
    libraries =
      (with pkgs; [
        libspatialite
        libxml2
        freetype
        fontconfig
        icu
        nss
        nspr
        stdenv.cc.cc.lib
      ])
      ++ (with pkgs.unstable; [ lightgbm ]);
  };

  # specialisation.gnome.configuration = {
  #   services.xserver = {
  #     enable = true;
  #     displayManager.gdm.enable = true;
  #     desktopManager.gnome.enable = true;
  #   };
  # };

  programs.ssh.startAgent = true;
  programs.ssh.enableAskPassword = true;
  programs.ssh.askPassword = "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
  programs.gnupg.agent.enableSSHSupport = false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  networking.firewall.allowedTCPPorts = [
    8888
    22
  ];

  # Do not remove
  system.stateVersion = "24.05";

  systemd.settings.Manager = {
    DefaultLimitNOFILE = lib.mkForce 1048576;
  };
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  programs.netextender.enable = true;

  custom.moneroNode.configFile = ../../secrets/hotbox-monerod-conf.age;
}
