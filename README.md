# Dotfiles & NixOS setup (flakes)

Personal NixOS setup with modular configuration for development, multimedia, and virtualization.

> [!CAUTION]
> Public repo. Adjust for your machine (disks, users, secrets). Wrong changes can break boot or lose data.

## Prereqs (once per machine)

```sh
# Enable flakes/CLI if not already
sudo mkdir -p /etc/nix
echo 'experimental-features = nix-command flakes' | sudo tee /etc/nix/nix.conf
````

## Host

This flake exposes a single NixOS host:

* `llathasa` — Lenovo ThinkPad T14 Gen 5 (Intel), XFCE desktop profile

```sh
export HOST=llathasa
```

## First use on a fresh install

```sh
git clone https://github.com/danilkiff/dotfiles-nix.git
cd dotfiles-nix

# Put your generated hardware config to the repo root:
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix

# Optional: verify flake outputs
nix flake show
```

## Lifecycle cheat-sheet

```sh
make check                            # validate flake
make install                          # apply config (dry-build then switch)
make update                           # bump flake inputs
sudo nixos-rebuild switch --rollback  # rollback to previous generation
sudo nix-collect-garbage -d           # manual GC (already wired daily)
```

## Makefile usage

Run `make` to explore available targets.

## License

MIT. See [LICENSE](LICENSE).