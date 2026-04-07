{
  description = "NixOS flakes config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        inherit overlays;
        config.allowUnfree = true;
      };

      overlays = [
        (_: prev: {
          sf-pro-fonts = prev.callPackage ./nixos/pkgs/sf-pro-fonts.nix { };
        })
      ];

      mkHost =
        hostPath:
        nixpkgs.lib.nixosSystem {
          modules = [
            {
              nixpkgs = {
                inherit overlays;
                config.allowUnfree = true;
              };
            }
            home-manager.nixosModules.home-manager
            hostPath
          ];
        };
    in
    {
      nixosConfigurations = {
        llathasa = mkHost ./nixos/hosts/llathasa/host.nix;
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git
          nixfmt-rfc-style
          statix
          deadnix
        ];
      };

      formatter.${system} = pkgs.nixfmt-rfc-style;

      checks.${system} = {

        fmt = pkgs.runCommand "fmt-check" { } ''
          ${pkgs.nixfmt-rfc-style}/bin/nixfmt --check ${self}
          mkdir -p $out
        '';

        statix = pkgs.runCommand "statix-check" { } ''
          ${pkgs.statix}/bin/statix check ${self}
          mkdir -p $out
        '';

        deadnix = pkgs.runCommand "deadnix-check" { } ''
          ${pkgs.deadnix}/bin/deadnix -f ${self}
          mkdir -p $out
        '';
      };
    };
}
