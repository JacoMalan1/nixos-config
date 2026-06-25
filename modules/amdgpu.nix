{ inputs, system, lib, ... }: 
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  boot.kernelParams = [
    "amdgpu.gpu_recovery=1"
  ];

  hardware.graphics = {
    enable = lib.mkForce true;
    enable32Bit = lib.mkForce true;
    extraPackages = with pkgs; [ vulkan-validation-layers ];
  };

  hardware.amdgpu = {
    opencl.enable = lib.mkForce true;
    initrd.enable = true;
    overdrive.enable = true;
  };

  environment.sessionVariables = {
    AMD_VULKAN_ICD = "RADV";
    radv_gfx12_hiz_wa = "full";
  };

  services.lact = {
    enable = true;
  };
}
