{
    description = "~baykovr/nix";

    inputs = rec {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
        };
        nix-search-cli = {
          url = "github:peterldowns/nix-search-cli";
          #inputs.follows = nixpkgs;
        };
    };
    outputs = {nixpkgs, home-manager, nix-search-cli, ...}: {
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
        homeConfigurations = {
          "baykovr" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { 
              system = "x86_64-linux"; 
              config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
                "terraform"
                "vscode"
                "code"
              ];
            };
            modules = [
              { 
                home.packages = [
                  nix-search-cli.packages.x86_64-linux.default
                ];
              }
              ./home.nix 
            ];
            };
        };
    };
}
