{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./user.nix

    ./nixos/modules/console.nix
    ./nixos/modules/docker.nix
    ./nixos/modules/gnupg.nix
    ./nixos/modules/libvirt.nix
    ./nixos/modules/locale.nix
    ./nixos/modules/ssh.nix
    ./nixos/modules/laptop.nix
    ./nixos/modules/desktop/fonts.nix
    ./nixos/modules/desktop/steam.nix
    ./nixos/modules/desktop/xfce.nix
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

  security = {
    rtkit.enable = true;
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
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

  services = {
    # journalctl --disk-usage
    journald.extraConfig = ''
      SystemMaxUse=1G
    '';
  };

  system.stateVersion = "25.05";
}
