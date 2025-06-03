.PHONY: help test install home check

# Help output
help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  test      - Build and run validation container (docker)"
	@echo "  install   - Run nixos-rebuild with current config"
	@echo "  home      - Run home-manager switch with current config"
	@echo "  check     - Dry-run NixOS build to catch all errors before deploy"
	@echo "  help      - Show this help message"

# Docker: validate NixOS config inside container
test:
	docker build -t nixos-validate .
	docker run --rm -it nixos-validate

# Dry-run NixOS build to catch all errors before deploy
check:
	sudo nixos-rebuild dry-build -I nixos-config=nixos/configuration.nix

# Apply NixOS config on local system
install: check
	sudo nixos-rebuild switch -I nixos-config=nixos/configuration.nix

# Apply NixOS Home Manager config on local system
home: check
	home-manager switch -f nixos/users/pikachu/home.nix


