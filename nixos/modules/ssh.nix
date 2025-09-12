{ config, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      X11Forwarding = true;
    };
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
  };

  programs.ssh.startAgent = true;

  security.sudo.extraConfig = ''
    Defaults env_keep += "SSH_AUTH_SOCK" # allow for sudo ssh
  '';
}