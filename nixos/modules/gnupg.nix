{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pinentry-gtk2
  ];

  programs = {
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
  };
}
