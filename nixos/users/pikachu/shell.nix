{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ 
          "git" "docker" "docker-compose"
          "python" "pip" "virtualenv"
          "tmux"
        ];
        theme = "gentoo";
      };
    };

    tmux.enable = true;
  };
}
