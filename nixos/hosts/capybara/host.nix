_: {
  imports = [
    ../../common.nix
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "capybara";
    hostId = "ed789665"; # head -c 8 /etc/machine-id
  };
}
