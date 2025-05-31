{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "docker" ];
      theme = "agnoster";
    };
  };

  environment.systemPackages = with pkgs; [
    git
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
  ];

  users.defaultUserShell = pkgs.zsh;
  virtualisation.docker.enable = true;
  users.users.pikachu.extraGroups = [ "docker" ];
}

