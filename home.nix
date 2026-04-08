{ pkgs, ... }:
{
  home = {
    username = "pikachu";
    homeDirectory = "/home/pikachu";
    stateVersion = "25.11";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim"; # for TUI/GUI
    };
  };

  home.packages = with pkgs; [
    curl
    dig
    file-roller
    flameshot
    gh
    gparted
    htop
    httpie
    iperf3
    jq
    libxfs
    lm_sensors
    man-pages
    man-pages-posix
    mc
    nmap
    openvpn
    p7zip
    pciutils
    pulsemixer
    redshift
    seahorse
    tree
    unrar
    unzip
    usbutils
    wget
    yq
    yt-dlp
    zip
  ];

  programs = {
    git = {
      enable = true;
      signing = {
        key = "386E2F77CD7D10E0";
        signByDefault = true;
      };
      settings = {
        user = {
          name = "Oleg Y. Danilkiff";
          email = "13948753+danilkiff@users.noreply.github.com";
        };
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
      # cnbs.lan: trusted private LAN with frequent VM/host re-provisioning,
      # which constantly invalidates known_hosts and triggers TOFU warnings.
      # Disabling host-key verification here is a deliberate trade-off and
      # MUST NOT be reused for any host outside this LAN.
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
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      history = {
        size = 100000;
        save = 100000;
        ignoreDups = true;
        ignoreSpace = true;
        share = true;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "docker"
          "docker-compose"
          "tmux"
        ];
        theme = "robbyrussell";
      };
    };

    tmux = {
      enable = true;
      extraConfig = ''
        set -g mouse on
        set -g default-terminal "tmux-256color"
      '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
