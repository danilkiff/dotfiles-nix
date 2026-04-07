_: {
  # ollama is intentionally exposed on 0.0.0.0:11434 to the trusted local LAN,
  # so other hosts in the same network can use the GPU-accelerated instance.
  # Do NOT enable this module on hosts that are reachable from untrusted networks.
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    host = "0.0.0.0";
    openFirewall = true;
  };
}
