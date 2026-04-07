{ pkgs, ... }:
let
  userName = "Oleg Y. Danilkiff";
  userEmail = "13948753+danilkiff@users.noreply.github.com";
  signKey = "386E2F77CD7D10E0";
in
{
  home = {
    username = "pikachu";
    homeDirectory = "/home/pikachu";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim"; # for TUI/GUI
    };
  };

  home.packages = with pkgs; [
    chromium
    curl
    dig
    discord
    file-roller
    firefox
    flameshot
    gnome-tweaks
    gnomeExtensions.pop-shell
    gpa
    gparted
    htop
    httpie
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    iperf3
    jq
    kubectl
    libxfs
    lm_sensors
    man-pages
    man-pages-posix
    mc
    nmap
    obsidian
    p7zip
    papers
    pciutils
    pulsemixer
    redshift
    telegram-desktop
    thunderbird-bin
    transmission_4-gtk
    tree
    unrar
    unzip
    usbutils
    vlc
    wget
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
        set -g default-terminal "tmux-256color"
      '';
    };
  };
}
