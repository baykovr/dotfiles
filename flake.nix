{
    description = "~baykovr/nix";

    inputs = rec {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        home-manager = {
            url = "github:nix-community/home-manager";
        };
        nix-search-cli = {
          url = "github:peterldowns/nix-search-cli";
          #inputs.follows = nixpkgs;
        };
        rust-overlay = {
          url = "github:oxalica/rust-overlay";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = {self, nixpkgs, home-manager, nix-search-cli, flake-utils, rust-overlay, ...}:
        let
          system = "aarch64-darwin";
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          packages.${system}.default = self.homeConfigurations.baykovr.activationPackage;

          homeConfigurations = {
            "baykovr" = home-manager.lib.homeManagerConfiguration {
              pkgs = import nixpkgs {
                system = "${system}";
                overlays = [ rust-overlay.overlays.default ];
                config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
                  "terraform"
                  "code"
                ];
              };
              modules = [
                {
                  home.packages = [
                    nix-search-cli.packages.${system}.default
                  ];
                }
                ./home.nix
              ];
            };
          };
        };
}
