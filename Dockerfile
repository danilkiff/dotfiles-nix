FROM nixos/nix:2.29.0

RUN mkdir -p /etc/nix && printf "experimental-features = nix-command flakes\n" > /etc/nix/nix.conf

WORKDIR /workspace
COPY . .

CMD ["nix", "flake", "check"]
