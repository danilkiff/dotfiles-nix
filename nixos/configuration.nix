{ config, pkgs, ... }:

{
  imports = [
    ./users/pikachu.nix
     <home-manager/nixos>

    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/virtualization.nix
  ];

  home-manager.users.pikachu = import ./users/pikachu/home.nix;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
  };

  services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = true;
    };
  };

  services.displayManager.defaultSession = "xfce";

  environment.systemPackages = with pkgs; [
    networkmanager
    networkmanager-openvpn
  ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}
