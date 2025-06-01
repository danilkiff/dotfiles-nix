{ config, pkgs, ... }:

{
  home.username = "pikachu";
  home.homeDirectory = "/home/pikachu";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    git
    gnupg
    neovim
    tmux
    docker
    docker-compose
    kubectl
    python311
    python311Packages.pip
    htop
    unzip
    curl
    wget
    mc
    vlc
    firefox
    chromium
    pulsemixer
    python311Packages.numpy
    python311Packages.scipy
    python311Packages.pandas
    python311Packages.jupyter
    python311Packages.torch
    python311Packages.tensorflow
    python311Packages.scikit-learn
    python311Packages.matplotlib
    python311Packages.notebook
    gnome-tweaks
    gnomeExtensions.pop-shell
    jetbrains-mono
    virt-manager
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "docker" ];
      theme = "agnoster";
    };
  };

  programs.git = {
    enable = true;
    userName = "Oleg Y. Danilkiff";
    userEmail = "13948753+danilkiff@users.noreply.github.com";
  };

  programs.gpg.enable = true;
  programs.ssh.enable = true;

  home.file.".ssh/config".source = ../../ssh/config;
}
