{ pkgs, ... }:
let
  sshPubKey = builtins.readFile ../../ssh/id_ed25519.pub;
in
{
  users.users.pikachu = {
    isNormalUser = true;
    home = "/home/pikachu";
    description = "Pikachu Overflow";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" "libvirtd" "transmission" ];
    openssh.authorizedKeys.keys = [ sshPubKey ];
  };
}
