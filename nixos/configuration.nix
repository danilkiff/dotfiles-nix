{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    
    ./modules/desktop-gnome.nix
    ./modules/dev-ohmyzsh.nix
    ./modules/media.nix
    ./modules/ml.nix
    ./modules/nvidia.nix
    
    ./users/pikachu.nix
  ];

  networking.hostName = "mynixbox";
  networking.firewall.enable = true;

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
  };

  security.sudo.wheelNeedsPassword = false;
}