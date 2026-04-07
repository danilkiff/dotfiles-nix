_: {
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../modules/laptop.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/steam.nix
    ../../modules/desktop/xfce.nix
  ];

  hardware.graphics.enable = true;

  networking = {
    hostName = "llathasa";
    hostId = "af714156"; # head -c 8 /etc/machine-id
  };

  system.stateVersion = "25.05";
  home-manager.users.pikachu.home.stateVersion = "25.05";
}
