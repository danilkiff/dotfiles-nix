{ pkgs, ... }:

{
  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };

  imports = [
    ./users/pikachu.nix

    ./modules/console.nix
    ./modules/docker.nix
    ./modules/gnupg.nix
    ./modules/libvirt.nix
    ./modules/locale.nix
    ./modules/ssh.nix
  ];

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
    users = {
      pikachu = import ./users/pikachu/home.nix;
    };
  };

  networking = {
    firewall.enable = true;
    networkmanager.enable = true;
    wireless.enable = false;
  };

  services = {
    # journalctl --disk-usage
    journald.extraConfig = ''
      SystemMaxUse=1G
    '';
  };

  system.stateVersion = "25.05";
}
