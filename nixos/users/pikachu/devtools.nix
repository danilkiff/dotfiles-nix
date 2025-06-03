{ pkgs, ... }:
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
    ];
  };
  programs = {
    git = {
      enable = true;
      userName = "Oleg Y. Danilkiff";
      userEmail = "13948753+danilkiff@users.noreply.github.com";
      signing = {
        key = "386E2F77CD7D10E0";
        signByDefault = true;
      };
    };
    gpg.enable = true;
    ssh.enable = true;
  };
}
