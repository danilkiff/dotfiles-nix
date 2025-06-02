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

## Local Validation

Requires Docker or Podman.
Launch `./run-tests`.

## Structure

- `nixos/` — system configs
- `ssh/` — SSH public key and config (private key is **not** tracked)
- `Dockerfile` — for validation and CI
- `.editorconfig` — coding style, 2-space everywhere
- `.gitignore`, `.dockerignore` — safety

## License

MIT. See [LICENSE](LICENSE) for details.
