{ config, pkgs, ... }:
{
  systemd.services.ollama.serviceConfig = {
    Environment = [ "OLLAMA_HOST=0.0.0.0:11434" ];
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    openFirewall = true;
  };
}