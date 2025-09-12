{ config, ... }:
{
  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # verify: docker run --rm --device=nvidia.com/gpu=all nvidia/cuda:12.2.0-base-ubuntu22.04 nvidia-smi
    nvidia-container-toolkit.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
