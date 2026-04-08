{ config, pkgs, ... }:
{
  home = {
    username = "pikachu";
    homeDirectory = "/home/pikachu";
    stateVersion = "25.11";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim"; # for TUI/GUI
      # Let starship render the venv segment instead of the activate
      # script prepending "(venv)" — otherwise we get it twice.
      VIRTUAL_ENV_DISABLE_PROMPT = "1";
      # Default flake path for `nh os switch` / `nh os boot`. Derived
      # from homeDirectory above so the absolute path is declared once.
      NH_FLAKE = "${config.home.homeDirectory}/dev/dotfiles-nix";
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

    # Modern engineering CLI. Mapping table lives in docs/CHEATSHEET.md.
    ripgrep # grep
    fd # find
    delta # git diff pager (wired via programs.git.delta)
    lazygit # git TUI
    gitui # alternative git TUI
    jless # less for JSON
    hyperfine # statistical benchmarking
    tokei # source line counter
    just # task runner / make alternative
    entr # rerun command on file change (line-based)
    watchexec # rerun command on file change (event-based)
    dua # disk usage scanner (fast, non-interactive)
    ncdu # disk usage browser (interactive TUI)
    duf # df with colors
    btop # top/htop replacement
    mtr # traceroute + ping combined
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
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          side-by-side = false;
          syntax-theme = "gruvbox-dark";
        };
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
        # Empty theme: starship takes over the prompt below.
        theme = "";
      };
    };

    # Prompt: starship. Default modules already render git status,
    # nix shell, and the active Python venv ($VIRTUAL_ENV) — the venv
    # segment is the headline requirement for this machine.
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        python = {
          # Show interpreter version + venv name on every prompt; do
          # not require a python project to render the venv segment.
          symbol = "py ";
          format = "via [\${symbol}\${pyenv_prefix}(\${version} )(\\($virtualenv\\) )]($style)";
          detect_extensions = [
            "py"
            "ipynb"
          ];
          detect_files = [
            "pyproject.toml"
            "requirements.txt"
            "setup.py"
            "Pipfile"
            ".python-version"
          ];
        };
        nix_shell = {
          symbol = "nix ";
          format = "via [$symbol$state( \\($name\\))]($style) ";
        };
      };
    };

    # File search / navigation upgrades. Each module wires its own
    # zsh integration (aliases, key bindings, completions).
    bat.enable = true;
    eza = {
      enable = true;
      enableZshIntegration = true; # aliases ls/ll/la/lt -> eza
      git = true;
      icons = "auto";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true; # Ctrl-R, Ctrl-T, Alt-C
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true; # adds `z` jump command
    };

    # WezTerm: GPU terminal, configured via Lua. home-manager auto-prepends
    # `local wezterm = require 'wezterm'` to the generated wezterm.lua, so
    # extraConfig below intentionally omits that line.
    # `macos_window_background_blur` is a no-op on Linux but is left in
    # for parity with the macOS workstation config.
    wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
        local act = wezterm.action

        local config = wezterm.config_builder()

        config.initial_cols = 140
        config.initial_rows = 40
        config.font_size = 18
        config.color_scheme = 'Everforest Dark (Gogh)'
        config.font = wezterm.font 'Cascadia Code'

        config.window_background_opacity = 0.8
        config.text_background_opacity   = 0.8 -- for nvim/tui
        config.macos_window_background_blur = 20

        -- Alt+Arrows: jump by word (send Esc+b / Esc+f)
        config.keys = {
          { key = 'LeftArrow',  mods = 'ALT', action = act.SendString '\x1bb' },
          { key = 'RightArrow', mods = 'ALT', action = act.SendString '\x1bf' },
        }

        return config
      '';
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
