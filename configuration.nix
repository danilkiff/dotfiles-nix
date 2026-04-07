{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./user.nix
    ./nixos/modules/laptop.nix
    ./modules/desktop.nix
    ./modules/virtualisation.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [
      "ntfs"
      "zfs"
    ];
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

  environment.systemPackages = with pkgs; [
    pinentry-gtk2
  ];

  programs = {
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
    ssh.startAgent = true;
  };

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
    hostId = "af714156"; # head -c 8 /etc/machine-id
    firewall.enable = true;
    networkmanager.enable = true;
    wireless.enable = false;
  };

  hardware.graphics.enable = true;

  services.journald.extraConfig = ''
    SystemMaxUse=1G
  '';

  system.stateVersion = "25.05";
}
