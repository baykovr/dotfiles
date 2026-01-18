{
    description = "~baykovr/nix";

    inputs = rec {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager";
        nix-search-cli.url = "github:peterldowns/nix-search-cli";
    };

    outputs = {nixpkgs, home-manager, nix-search-cli, ...}:
    let
      mkHome = { system, username, homeDir }: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            "terraform" "vscode" "code"
          ];
        };
        extraSpecialArgs = {
          inherit username homeDir system;
          isDarwin = builtins.match ".*-darwin" system != null;
        };
        modules = [
          { home.packages = [ nix-search-cli.packages.${system}.default ]; }
          ./home.nix
        ];
      };
    in {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      homeConfigurations = {
        "ethos" = mkHome {
          system = "x86_64-linux";
          username = "ethos";
          homeDir = "/home/ethos";
        };
        "baykovr" = mkHome {
          system = "aarch64-darwin";
          username = "baykovr";
          homeDir = "/Users/baykovr";
        };
      };
    };
}
