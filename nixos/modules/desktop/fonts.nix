{ pkgs, ... }:
{
  fonts = {
    packages = [ pkgs.sf-pro-fonts ];
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
