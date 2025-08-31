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
      python313
      python313Packages.pip
      python313Packages.pipx
      poetry
      jetbrains.pycharm-professional
      jetbrains.idea-ultimate
      jetbrains.goland
      jetbrains.rust-rover
      rustc
      rustfmt
      cargo
      iperf3
      nmap
      lm_sensors
      man-pages
      man-pages-posix
      pciutils
      usbutils
      android-tools
      tree
      dig
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
