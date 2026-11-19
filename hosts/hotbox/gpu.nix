{ ... }:
{
  boot.kernelParams = [ "amdgpu.gpu_recovery=1" ];

  hardware.amdgpu.overdrive.enable = true;

  environment.sessionVariables.radv_gfx12_hiz_wa = "full";

  services.lact.enable = true;
}
