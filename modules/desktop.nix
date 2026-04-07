{ pkgs, ... }:
{
  services.displayManager.defaultSession = "xfce";
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    xkb = {
      layout = "us,ru";
      options = "grp:win_space_toggle,grp:alt_shift_toggle";
    };
  };

  environment.systemPackages = with pkgs; [
    xfce.xfce4-panel-profiles
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfce4-icon-theme
    xfce.ristretto

    gruvbox-material-gtk-theme
    gruvbox-gtk-theme
    gruvbox-plus-icons
    gruvbox-dark-icons-gtk

    networkmanager
    networkmanager-openvpn
  ];

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-vcs-plugin
      ];
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      sf-pro-fonts
      cascadia-code
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.iosevka-term
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu-sans
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "SF Pro Text" ];
        sansSerif = [ "SF Pro Display" ];
        monospace = [ "SF Mono" ];
      };
    };
  };
}
