{ inputs, system, lib, config, ... }:
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };

  boot.kernelParams = [ "nvidia_drm.modeset=1" "nvidia_drm.fbdev=1" ];

  boot.kernelModules =
    [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" "i2c-nvidia_gpu" ];

  environment.systemPackages = with pkgs; [
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;

    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "575.64.05";
      sha256_64bit = "sha256-hfK1D5EiYcGRegss9+H5dDr/0Aj9wPIJ9NVWP3dNUC0=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = lib.fakeSha256;
      settingsSha256 = lib.fakeSha256;
      persistencedSha256 = lib.fakeSha256;
    };
  };
}
