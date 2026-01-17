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
    };
    outputs = {self, nixpkgs, home-manager, nix-search-cli, flake-utils, ...}:
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
