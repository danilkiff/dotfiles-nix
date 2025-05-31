{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vlc
    firefox
    chromium
    pulsemixer
  ];
}

