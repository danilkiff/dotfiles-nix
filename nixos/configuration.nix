{ config, pkgs, ... }:

{
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  imports = [
    ./users/pikachu.nix

    ./hardware-configuration.nix

    ./modules/console.nix
    ./modules/docker.nix
    ./modules/gnupg.nix
    ./modules/libvirt.nix
    ./modules/locale.nix
    ./modules/nvidia.nix
    ./modules/ollama.nix
    ./modules/ssh.nix

    ./modules/desktop/fonts.nix
    ./modules/desktop/steam.nix
    ./modules/desktop/xfce.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
    settings = {
      auto-optimise-store = true;
      keep-derivations = false;
      keep-outputs = false;
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  security = {
    rtkit.enable = true;
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
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

  services = {
    # journalctl --disk-usage
    journald.extraConfig = ''
      SystemMaxUse=1G
    '';
  };

  system.stateVersion = "25.05";
}
