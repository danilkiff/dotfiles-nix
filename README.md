# Dotfiles & NixOS setup

Personal NixOS setup with modular configuration for development, multimedia, and virtualization.

> [!CAUTION]
> This repo is public and intended for your own learning and research.
> Always apply all necessary changes for your own configuration —
> otherwise, you risk making your system unbootable or losing data.

## Usage

1. Clone the repo after NixOS installation.
2. Copy your `hardware-configuration.nix` into the `nixos/` directory.
3. Run `nixos-rebuild switch -I nixos-config=nixos/configuration.nix`.
4. **Never commit your private SSH key!**


## Makefile Usage

You can manage most common actions via the `Makefile` in the project root. Use `make help` for available targets.

## License

MIT. See [LICENSE](LICENSE) for details.
