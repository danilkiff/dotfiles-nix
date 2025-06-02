{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  
  home.packages = with pkgs; [
    neovim
    obsidian
  ];
  
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-toolsai.jupyter
      ms-azuretools.vscode-docker
      jdinhlife.gruvbox
    ];
  };
}
