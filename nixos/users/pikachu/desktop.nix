{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.pop-shell
    jetbrains-mono
    cascadia-code
    vlc
    firefox
    chromium
    pulsemixer
    virt-manager
    redshift
    flameshot
    evince
    papers
  ];
}
