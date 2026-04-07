.PHONY: help test check eval dry install gc fmt

HOST ?= llathasa

help:
	@echo "HOST=[llathasa]"
	@echo "Targets:"
	@echo "  check     - nix flake check (CI-safe)"
	@echo "  eval      - Evaluate host toplevel drvPath (CI-safe)"
	@echo "  test      - Build and run validation container (docker)"
	@echo "  dry       - nixos-rebuild dry-build (NixOS host only)"
	@echo "  install   - nixos-rebuild switch (NixOS host only)"
	@echo "  gc        - Garbage-collect"
	@echo "  fmt       - Format Nix files"

check:
	@nix flake check --print-build-logs

eval:
	@nix eval .#nixosConfigurations.$(HOST).config.system.build.toplevel.drvPath

test:
	@docker build -t nixos-validate .
	@docker run --rm -i nixos-validate

dry:
	@sudo nixos-rebuild dry-build --flake .#$(HOST)

install: check
	@sudo nixos-rebuild switch --flake .#$(HOST)

gc:
	@sudo nix-collect-garbage -d
	@nixos-rebuild list-generations

fmt:
	@nix fmt -- **/*.nix
