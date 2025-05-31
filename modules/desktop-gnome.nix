{ pkgs, ... }:
{
  services.xserver = {
    enable = true;

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle";
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.pop-shell
  ];

  fonts.fonts = with pkgs; [ 
    jetbrains-mono 
  ];
}
