{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim"; # for TUI/GUI
  };

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "docker"
          "docker-compose"
          "python"
          "pip"
          "virtualenv"
          "tmux"
        ];
        theme = "robbyrussell";
      };
      initContent = ''
        if ! ssh-add -l &>/dev/null; then
          ssh-add 2> /dev/null
        fi
      '';
    };

    tmux = {
      enable = true;
      extraConfig = ''
        set -g mouse on
        set -g default-terminal "xterm-256color"
      '';
    };
  };
}
