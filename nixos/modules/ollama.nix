_: {
  # ollama is intentionally exposed on 0.0.0.0:11434 to the trusted local LAN,
  # so other hosts in the same network can use the GPU-accelerated instance.
  # Do NOT enable this module on hosts that are reachable from untrusted networks.
  systemd.services.ollama.serviceConfig = {
    Environment = [ "OLLAMA_HOST=0.0.0.0:11434" ];
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    openFirewall = true;
  };
}
