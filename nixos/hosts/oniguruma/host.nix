_: {
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../modules/nvidia.nix
    ../../modules/ollama.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/steam.nix
    ../../modules/desktop/xfce.nix
  ];

  networking = {
    hostName = "oniguruma";
    hostId = "cc380966"; # head -c 8 /etc/machine-id
  };

  system.stateVersion = "25.05";
  home-manager.users.pikachu.home.stateVersion = "25.05";
}
