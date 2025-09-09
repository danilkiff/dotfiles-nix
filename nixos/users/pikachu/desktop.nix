{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.pop-shell

    cascadia-code

    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.iosevka-term
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu-mono
    nerd-fonts.meslo-lg

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

    yt-dlp
    zotero
  ];
}
