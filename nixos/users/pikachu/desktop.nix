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

    p7zip
    unzip
    unrar
    zip
    file-roller

    transmission_4-gtk
    discord
    telegram-desktop
    thunderbird-bin
    yandex-disk

    keepassxc
    seahorse
    gpa

    gparted
    libxfs
  ];
}
