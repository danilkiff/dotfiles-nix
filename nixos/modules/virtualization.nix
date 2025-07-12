{ pkgs, ... }:
{
  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        registry-mirrors = [ "https://nexus.z.pq3.ru" ];
      };
    };
    podman.enable = false;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}

