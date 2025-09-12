_: {
  imports = [
    ../../common.nix
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "hellicopter";
    hostId = "cc380966"; # head -c 8 /etc/machine-id
  };
}
