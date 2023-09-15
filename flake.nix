{
    description = "~baykovr/nix";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
        };
    };

    outputs = {nixpkgs, home-manager, ...}: {
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
        homeConfigurations = {
            "baykovr" = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { system = "x86_64-linux"; };
                modules = [ ./home.nix ];
            };
        };
    };
}
