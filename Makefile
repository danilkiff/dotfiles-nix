.PHONY: help test check install gc fmt devshell

help:
	@echo "Targets:"
	@echo "  test      - Build and run validation container (docker)"
	@echo "  check     - nix flake check + dry-build"
	@echo "  install   - nixos-rebuild switch --flake"
	@echo "  gc        - Garbage-collect"
	@echo "  fmt       - Format Nix files"

test:
	@docker build -t nixos-validate .
	@docker run --rm -it nixos-validate

check:
	@nix flake check
	@sudo nixos-rebuild dry-build --flake .#oniguruma

install: check
	@sudo nixos-rebuild switch --flake .#oniguruma

gc:
	@sudo nix-collect-garbage -d
	@nixos-rebuild list-generations

fmt:
	@nix fmt -- **/*.nix
