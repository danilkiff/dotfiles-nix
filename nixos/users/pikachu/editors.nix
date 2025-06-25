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
    obsidian
    libreoffice
    onlyoffice-bin
    hunspell
    hunspellDicts.ru_RU
    hunspellDicts.en_US
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-toolsai.jupyter
      ms-azuretools.vscode-docker
      jdinhlife.gruvbox
      james-yu.latex-workshop
    ];
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
    ];

    extraConfig = builtins.readFile ./nvim-config.vim;
  };
}
