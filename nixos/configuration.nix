{ config, pkgs, ... }:

{
  imports = [
    ./users/pikachu.nix
     <home-manager/nixos>

    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/virtualization.nix
  ];

  home-manager.users.pikachu = import ./users/pikachu/home.nix;

  networking.hostName = "oniguruma";
  networking.firewall.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
  };

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}