{ pkgs, ... }:
let
  userName  = "Oleg Y. Danilkiff";
  userEmail = "13948753+danilkiff@users.noreply.github.com";
  signKey   = "386E2F77CD7D10E0";
in
{
  home = {
    file.".ssh/config".source = ../../../ssh/config;
    packages = with pkgs; [
      httpie
      jq
      git
      gnupg
      docker
      docker-compose
      kubectl
      htop
      unzip
      curl
      wget
      mc
      gnumake
      gcc
      python311 
      python311Packages.pip
      jetbrains.pycharm-professional
      jetbrains.idea-ultimate
      jetbrains.goland
    ];
  };
  programs = {
    git = {
      enable = true;
      userName = userName;
      userEmail = userEmail;
      signing = {
        key = signKey;
        signByDefault = true;
      };
    };
    gpg.enable = true;
    ssh.enable = true;
  };
}
