{ config, pkgs, ... }:
{
  home = {
    username = "pikachu";
    homeDirectory = "/home/pikachu";
    stateVersion = "25.05";
  };

  imports = [
    ./desktop.nix
    ./devtools.nix
    ./editors.nix
    ./shell.nix
  ];
}
