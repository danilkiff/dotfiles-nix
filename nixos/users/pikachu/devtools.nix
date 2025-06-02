{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
  ];

  programs.git = {
    enable = true;
    userName = "Oleg Y. Danilkiff";
    userEmail = "13948753+danilkiff@users.noreply.github.com";

    signing = {
      key = "386E2F77CD7D10E0";
      signByDefault = true;
    };
  };

  programs.gpg.enable = true;
  programs.ssh.enable = true;

  home.file.".ssh/config".source = ../../../ssh/config;
}
