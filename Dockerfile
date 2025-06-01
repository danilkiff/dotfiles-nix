FROM nixos/nix:2.29.0

WORKDIR /workspace

RUN nix-env -iA nixpkgs.nixpkgs-fmt

RUN nix-channel --add https://nixos.org/channels/nixos-25.05 nixpkgs && \
    nix-channel --update

RUN nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager && \
    nix-channel --update

COPY . .

RUN [ -f nixos/hardware-configuration.nix ] || cp nixos/template-hardware-configuration.nix nixos/hardware-configuration.nix

CMD ["nix-instantiate", "<nixpkgs/nixos>", \
        "-A", "system", \
        "-I", "nixos-config=nixos/configuration.nix" \
]

