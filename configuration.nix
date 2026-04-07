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
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
    tmp.cleanOnBoot = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      keep-derivations = false;
      keep-outputs = false;
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
    # command-not-found's DB isn't populated on flake systems; disable noise.
    command-not-found.enable = false;
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
  };

  # pinentry-gnome3 needs gcr's D-Bus service to display prompts on XFCE.
  services.dbus.packages = [ pkgs.gcr ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      X11Forwarding = true;
    };
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
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
    users.pikachu = {
      imports = [ ./home.nix ];
      home.stateVersion = "25.05";
    };
  };

  networking = {
    hostName = "llathasa";
    nftables.enable = true;
    firewall.enable = true;
    networkmanager.enable = true;
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

  system.stateVersion = "25.05";
}
