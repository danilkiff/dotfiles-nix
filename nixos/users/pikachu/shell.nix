{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "python" "docker" ];
        theme = "gentoo";
      };
    };

    tmux.enable = true;
  };
}
