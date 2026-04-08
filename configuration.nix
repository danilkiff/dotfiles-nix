{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./user.nix
    ./modules/laptop.nix
    ./modules/desktop.nix
    ./modules/virtualisation.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # Cap stored generations so the EFI partition can't fill up.
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
    tmp.cleanOnBoot = true;
    # Raise inotify ceilings for IDEs, bundlers, and file watchers
    # that crash silently on busy monorepos.
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 512;
    };
  };

  nix = {
    # GC is delegated to programs.nh.clean below — they are mutually
    # exclusive, and nh gives nicer output and `--keep N` semantics.
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  time.timeZone = "Europe/Moscow";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  console = {
    earlySetup = true;
    font = "ter-v16n";
    packages = [ pkgs.terminus_font ];
    useXkbConfig = true;
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
    # command-not-found's DB isn't populated on flake systems; disable noise.
    command-not-found.enable = false;
    # Replacement for command-not-found: prebuilt index of nixpkgs binaries,
    # plus `nix-locate` for "which package ships /usr/bin/foo".
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        openssl
        curl
        glib
        icu
        libxml2
        libxcrypt
      ];
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    # nh: friendlier wrapper over nixos-rebuild + store GC.
    # `nh os switch` for rebuilds, `nh clean all` for GC.
    # Default flake path is exported as $NH_FLAKE from home.nix so that
    # the absolute path lives next to home.homeDirectory, not here.
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 5";
      };
    };

    # Wireshark with the dumpcap helper so non-root capture works for
    # users in the `wireshark` group (see user.nix).
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  # pinentry-gnome3 needs gcr's D-Bus service to display prompts on XFCE.
  services.dbus.packages = [ pkgs.gcr ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  security = {
    rtkit.enable = true;
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
      extraConfig = ''
        Defaults env_keep += "SSH_AUTH_SOCK" # allow for sudo ssh
      '';
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.pikachu.imports = [ ./home.nix ];
  };

  # Install man pages from sections 2/3 (syscalls, libc) — needed when
  # actually writing C/Rust/Go FFI rather than just running tools.
  documentation.dev.enable = true;

  networking = {
    hostName = "llathasa";
    nftables.enable = true;
    firewall.enable = true;
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
        networkmanager-openvpn
      ];
    };
    wireless.enable = false;
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      # Intel Quick Sync / VAAPI for hardware video decode in browsers, mpv, etc.
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
      ];
    };
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=1G
  '';

  # Userspace OOM killer: reacts in seconds, kills the heaviest process
  # before the kernel falls into a multi-minute swap thrash.
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeSwapThreshold = 10;
  };

  # SMART monitoring for the NVMe — surfaces failing disks early.
  services.smartd = {
    enable = true;
    autodetect = true;
    notifications = {
      x11.enable = true;
      wall.enable = true;
    };
  };

  system.stateVersion = "25.11";
}
