{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
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
}
