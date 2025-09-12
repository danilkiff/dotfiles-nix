{ config, pkgs, ... }:

let
  sf-pro-fonts = pkgs.callPackage ../../pkgs/sf-pro-fonts.nix { };
in
{
  fonts = {
    packages = [ sf-pro-fonts ];
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