{ config, pkgs, ... }:
let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full;
  };
in
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    tex
    texstudio
    neovim
    obsidian
    libreoffice
    onlyoffice-bin
    hunspell
    hunspellDicts.ru_RU
    hunspellDicts.en_US
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
      james-yu.latex-workshop
    ];
  };
}
