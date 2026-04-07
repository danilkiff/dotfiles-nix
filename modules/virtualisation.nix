{ pkgs, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        registry-mirrors = [ "https://nexus.z.pq3.ru" ];
      };
    };
    libvirtd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}
