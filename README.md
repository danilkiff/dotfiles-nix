# Dotfiles & NixOS setup (flakes)

Personal NixOS setup with modular configuration for development, multimedia, and virtualization.

> [!CAUTION]
> This repo is public and intended for your own learning and research.
> Always apply all necessary changes for your own configuration —
> otherwise, you risk making your system unbootable or losing data.

## Prereqs (once per machine)

```sh
# Enable flakes/CLI if not already
sudo mkdir -p /etc/nix
echo 'experimental-features = nix-command flakes' | sudo tee /etc/nix/nix.conf
````

## First use on a fresh install

```sh
git clone https://github.com/danilkiff/dotfiles.git
cd dotfiles

# Put your generated hardware config here (or edit the template)
# cp /etc/nixos/hardware-configuration.nix nixos/hardware-configuration.nix

# Optional: verify flake outputs
nix flake show
```

## Lifecycle cheat-sheet (assuming hostname is `oniguruma`)

### Inspect / Validate

```sh
# Fast evaluation (no builds)
nix eval .#nixosConfigurations.oniguruma.config.system.build.toplevel.drvPath

# Static checks (fmt/statix/deadnix) — wired via flake checks
nix flake check
```

### Build (without switching) / Smoke-test

```sh
# Build system closure only
nix build .#nixosConfigurations.oniguruma.config.system.build.toplevel
# Result symlink: ./result
```

### Apply system (Home-Manager included)

```sh
# Dry run (fully evaluate + plan)
sudo nixos-rebuild dry-build --flake .#oniguruma

# Test (activate until next reboot)
sudo nixos-rebuild test --flake .#oniguruma

# Switch (activate now)
sudo nixos-rebuild switch --flake .#oniguruma

# Safer rollout: stage for next boot
sudo nixos-rebuild boot --flake .#oniguruma
```

### Rollback

```sh
# To previous generation
sudo nixos-rebuild switch --rollback
# Or pick an older generation from the bootloader menu
```

### Update inputs (nixpkgs, home-manager, etc.)

```sh
# Update everything pinned in flake.lock
nix flake update

# Update only nixpkgs
nix flake lock --update-input nixpkgs

# Pin nixpkgs to a specific commit/branch
nix flake lock --update-input nixpkgs github:NixOS/nixpkgs/<rev-or-branch>

# Then rebuild
sudo nixos-rebuild switch --flake .#oniguruma
```

### Garbage collection / Store maintenance

```sh
# Remove old generations (system + users) and free space
sudo nix-collect-garbage -d

# Deduplicate Nix store
sudo nix store optimise
```

### Formatting & linters (local)

```sh
# Format tracked *.nix quickly
nix fmt -- **/*.nix

# Or run individual tools
nix run nixpkgs#nixfmt-rfc-style -- -w $(git ls-files '*.nix')
nix run nixpkgs#statix -- check .
nix run nixpkgs#deadnix -- -f .
```

### CI tips

* Fast path (per PR): `nix flake check` + `nix eval .#…toplevel.drvPath`
* Heavy path (on demand): `nix build .#nixosConfigurations.oniguruma.config.system.build.toplevel`

## Makefile Usage

You can manage most common actions via the `Makefile` in the project root. Use `make help` for available targets.

## License

MIT. See [LICENSE](LICENSE) for details.
