{ config, pkgs, ... }:

{
  imports = [
    ./users/pikachu.nix
     <home-manager/nixos>

    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/virtualization.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    home-manager
    networkmanager
    networkmanager-openvpn
    pinentry-gtk2

    xfce.xfce4-panel-profiles
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfce4-icon-theme
    xfce.ristretto

    gruvbox-material-gtk-theme
    gruvbox-gtk-theme

    gruvbox-plus-icons
    gruvbox-dark-icons-gtk

  ];

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  programs = {
    zsh.enable = true;
    
    ssh.startAgent = true;

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ 
        thunar-archive-plugin
        thunar-volman
        thunar-vcs-plugin
      ];
    };
  };
  
  home-manager = {
    backupFileExtension = "backup";
    users = {
      pikachu = import ./users/pikachu/home.nix;
    };
  };
  
  networking = {
    hostName = "oniguruma";
    firewall.enable = true;
    networkmanager.enable = true;
    wireless.enable = false;
  };

  # Locale settings
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

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        X11Forwarding = true;
      };
      authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
    };
    xserver = {
      enable = true;
      desktopManager = {
        xfce.enable = true;
      };
      xkb = {
        layout = "us,ru";
        options = "grp:win_space_toggle";
      };
    };
    displayManager.defaultSession = "xfce";
    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  system.stateVersion = "25.05";
}
