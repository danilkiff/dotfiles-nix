{ pkgs, ... }:
{
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
    podman.enable = false;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}

