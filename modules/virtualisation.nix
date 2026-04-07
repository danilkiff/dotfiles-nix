_: {
  virtualisation.docker = {
    enable = true;

    # Reclaim disk weekly. Intentionally omits --volumes: named volumes
    # frequently hold dev databases and must not be wiped automatically.
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };

    daemon.settings = {
      registry-mirrors = [ "https://nexus.z.pq3.ru" ];
      # Cap per-container log growth so a chatty service can't fill the disk.
      log-driver = "json-file";
      log-opts = {
        max-size = "10m";
        max-file = "3";
      };
    };
  };
}
