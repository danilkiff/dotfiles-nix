# Dotfiles & NixOS setup (flakes)

Personal NixOS setup with modular configuration for development, multimedia, and virtualization.

> [!CAUTION]
> Public repo. Adjust for your machines (disks, users, secrets). Wrong changes can break boot or lose data.
> If you use ZFS, each host **must** have a unique `networking.hostId` (8 hex chars).

## Prereqs (once per machine)

```sh
# Enable flakes/CLI if not already
sudo mkdir -p /etc/nix
echo 'experimental-features = nix-command flakes' | sudo tee /etc/nix/nix.conf
````

## Hosts

Available NixOS hosts (flake outputs):

* `oniguruma` — desktop profile
* `capybara`
* `hellicopter`

Pick the current machine’s host and export it for convenience:

```sh
export HOST=oniguruma   # or: capybara | hellicopter
```

## First use on a fresh install

```sh
git clone https://github.com/danilkiff/dotfiles.git
cd dotfiles

# Put your generated hardware config to the host folder:
sudo nixos-generate-config --show-hardware-config > nixos/hosts/$HOST/hardware-configuration.nix

# Optional: verify flake outputs
nix flake show
```

## Lifecycle cheat-sheet (multihost)

### Inspect / Validate

```sh
# Fast evaluation (no builds)
nix eval .#nixosConfigurations.$HOST.config.system.build.toplevel.drvPath

# Static checks (fmt/statix/deadnix) — wired via flake checks
nix flake check
```

### Build (without switching) / Smoke-test

```sh
# Build system closure only
nix build .#nixosConfigurations.$HOST.config.system.build.toplevel
# Result symlink: ./result
```

### Apply system (Home-Manager included)

```sh
# Dry run (fully evaluate + plan)
sudo nixos-rebuild dry-build --flake .#$HOST

# Test (activate until next reboot)
sudo nixos-rebuild test --flake .#$HOST

# Switch (activate now)
sudo nixos-rebuild switch --flake .#$HOST

# Safer rollout: stage for next boot
sudo nixos-rebuild boot --flake .#$HOST
```

### Rollback

```sh
sudo nixos-rebuild switch --rollback
# or select an older generation in the bootloader menu
```

### Update inputs (nixpkgs, home-manager, etc.)

```sh
# Update everything pinned in flake.lock
nix flake update

# Update only nixpkgs
nix flake lock --update-input nixpkgs

# Pin nixpkgs to a specific commit/branch
nix flake lock --update-input nixpkgs github:NixOS/nixpkgs/<rev-or-branch>

# Then rebuild the selected host
sudo nixos-rebuild switch --flake .#$HOST
```

### Garbage collection / Store maintenance

```sh
sudo nix-collect-garbage -d      # remove old generations
sudo nix store optimise          # deduplicate the Nix store
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

* Fast path (per PR): `nix flake check` + `nix eval .#nixosConfigurations.<host>.config.system.build.toplevel.drvPath`
* Heavy path (on demand/matrix): `nix build .#nixosConfigurations.<host>.config.system.build.toplevel` for each host

## Makefile usage

Targets accept `HOST=<oniguruma|capybara|hellicopter>`:

```sh
make check HOST=$HOST
make install HOST=$HOST
make build HOST=$HOST
make gc
make fmt
```

## License

MIT. See [LICENSE](LICENSE).