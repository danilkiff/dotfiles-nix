{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      sf-pro-fonts
      cascadia-code
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.iosevka-term
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu-sans
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "SF Pro Text" ];
        sansSerif = [ "SF Pro Display" ];
        monospace = [ "SF Mono" ];
      };
    };
  };
}
