{ ... }:
{
  virtualisation.docker = {
    enable = true;

    # Reclaim disk weekly. Intentionally omits --volumes: named volumes
    # frequently hold dev databases and must not be wiped automatically.
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };

    # Cap per-container log growth so a chatty service can't fill the disk.
    daemon.settings = {
      log-driver = "json-file";
      log-opts = {
        max-size = "10m";
        max-file = "3";
      };
    };
  };
}
