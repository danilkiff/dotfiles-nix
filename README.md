# Dotfiles & NixOS setup

> Personal NixOS setup with modular configuration for development, multimedia, and virtualization.

## Usage

1. Clone the repo after NixOS installation.
2. Copy your `hardware-configuration.nix` into the `nixos/` directory.
3. Run `sudo nixos-rebuild switch --flake .#` or use the classic switch.
4. **Never commit your private SSH key!**

## Structure

- `nixos/` — system configs
- `.config/` — user dotfiles
- `ssh/` — SSH public key and config (private key is **not** tracked)

> [!CAUTION]
> This repo is public and intended for your own learning and research.  
> Always apply all necessary changes for your own configuration —  
> otherwise, you risk making your system unbootable or losing data.

