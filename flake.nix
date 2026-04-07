{
  description = "Personal NixOS config for llathasa (ThinkPad T14)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      treefmt-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      treefmtEval = treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
        };
        programs.statix.enable = true;
        programs.deadnix.enable = true;
      };
    in
    {
      nixosConfigurations.llathasa = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          { nixpkgs.config.allowUnfree = true; }
          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.git
          treefmtEval.config.build.wrapper
        ];
      };

      formatter.${system} = treefmtEval.config.build.wrapper;

      checks.${system}.formatting = treefmtEval.config.build.check self;
    };
}
