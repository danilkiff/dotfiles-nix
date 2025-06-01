{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.pop-shell
    jetbrains-mono
    vlc
    firefox
    chromium
    pulsemixer
    virt-manager
  ];
}
