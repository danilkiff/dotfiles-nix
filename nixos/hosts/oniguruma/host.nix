{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    (inputs.self + /nixos/common.nix)
    (inputs.self + /nixos/modules/nvidia.nix)
    (inputs.self + /nixos/modules/ollama.nix)
    (inputs.self + /nixos/modules/desktop/fonts.nix)
    (inputs.self + /nixos/modules/desktop/steam.nix)
    (inputs.self + /nixos/modules/desktop/xfce.nix)
  ];

  networking = {
    hostName = "oniguruma";
    hostId = "cc380966";
  };
}
