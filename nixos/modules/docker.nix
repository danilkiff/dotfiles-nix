_: {
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        registry-mirrors = [ "https://nexus.z.pq3.ru" ];
      };
    };
  };
}
