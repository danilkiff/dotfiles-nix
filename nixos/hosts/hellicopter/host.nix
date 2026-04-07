_: {
  imports = [
    ../../common.nix
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "hellicopter";
    hostId = "ab415268"; # head -c 8 /etc/machine-id
  };

  system.stateVersion = "25.05";
  home-manager.users.pikachu.home.stateVersion = "25.05";
}
