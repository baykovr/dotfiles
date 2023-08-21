{pkgs, ...}: {
    home.username = "baykovr";
    home.homeDirectory = "/home/baykovr";
    home.stateVersion = "23.05"; 
    programs.home-manager.enable = true;
    home.packages = [
        pkgs.nixpkgs-fmt
    ];

}
