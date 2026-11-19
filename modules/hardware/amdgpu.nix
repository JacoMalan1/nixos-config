{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ vulkan-validation-layers ];
  };

  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
  };

  environment.sessionVariables.AMD_VULKAN_ICD = "RADV";
}
