{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ 
          "git" "docker" "docker-compose"
          "python" "pip" "virtualenv" "conda" "conda-env"
          "tmux"
        ];
        theme = "essembeh";
      };
    };

    tmux.enable = true;
  };
}
