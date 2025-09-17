{ pkgs, ... }:
let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full;
  };

  userName = "Oleg Y. Danilkiff";
  userEmail = "13948753+danilkiff@users.noreply.github.com";
  signKey = "386E2F77CD7D10E0";

in
{
  home = {
    username = "pikachu";
    homeDirectory = "/home/pikachu";
    stateVersion = "25.05";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim"; # for TUI/GUI
    };
  };

  home.packages = with pkgs; [
    android-tools
    cargo
    cascadia-code
    chromium
    curl
    dig
    discord
    docker
    docker-compose
    evince
    file-roller
    firefox
    flameshot
    gcc
    git
    gnome-tweaks
    gnomeExtensions.pop-shell
    gnumake
    gnupg
    gpa
    gparted
    htop
    httpie
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    iperf3
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.rust-rover
    jq
    keepassxc
    kubectl
    libreoffice
    libxfs
    lm_sensors
    man-pages
    man-pages-posix
    mc
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.iosevka-term
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
    nmap
    obsidian
    onlyoffice-bin
    p7zip
    papers
    pciutils
    poetry
    pulsemixer
    python313
    python313Packages.pip
    python313Packages.pipx
    redshift
    rustc
    rustfmt
    seahorse
    sublime4
    telegram-desktop
    tex
    texstudio
    thunderbird-bin
    transmission_4-gtk
    tree
    unrar
    unzip
    usbutils
    vlc
    wget
    windsurf
    yandex-disk
    yt-dlp
    zip
    zotero
  ];

  programs = {
    git = {
      enable = true;
      inherit userName userEmail;
      signing = {
        key = signKey;
        signByDefault = true;
      };
      extraConfig = {
        push.autoSetupRemote = true;
        pull.ff = "only";
        init.defaultBranch = "main";
        log = {
          decorate = true;
          abbrevCommit = true;
        };
        core.compression = 0;
      };
    };
    gpg.enable = true;

    ssh.enable = true;
    ssh.matchBlocks = {
      "github.com" = {
        host = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa";
        identitiesOnly = true;
      };
      "gitea.z.pq3.ru" = {
        host = "gitea.z.pq3.ru";
        port = 222;
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      "*.cnbs.lan" = {
        host = "*.cnbs.lan";
        user = "pikachu";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
        extraOptions = {
          StrictHostKeyChecking = "no";
          UserKnownHostsFile = "/dev/null";
          "SetEnv" = ''LC_ALL="en_US.UTF-8" LC_CTYPE="en_US.UTF-8"'';
        };
      };
      "*" = {
        host = "*";
        extraOptions = {
          VisualHostKey = "yes";
        };
      };
    };

    vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-toolsai.jupyter
        ms-azuretools.vscode-docker
        jdinhlife.gruvbox
        james-yu.latex-workshop
      ];
    };

    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;

      plugins = with pkgs.vimPlugins; [
        editorconfig-vim
      ];

      extraConfig = builtins.readFile ./nvim-config.vim;
    };

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "docker"
          "docker-compose"
          "python"
          "pyenv"
          "pip"
          "tmux"
          "rust"
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
