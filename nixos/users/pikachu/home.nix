{ config, pkgs, ... }:

{
  home.username = "pikachu";
  home.homeDirectory = "/home/pikachu";
  home.stateVersion = "25.05";

  imports = [
    ./desktop.nix
    ./devtools.nix
    ./editors.nix
    ./ml.nix
    ./shell.nix  
  ];
}
