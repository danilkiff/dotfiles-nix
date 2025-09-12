{ config, pkgs, ... }:
{
  programs = {
    zsh.enable = true;
  };

  console =  {
    earlySetup = true;
    font = "ter-v16n";
    packages = [ pkgs.terminus_font ];
    useXkbConfig = true;
  };
}

