{pkgs, lib, ...}: {
    home.username = "baykovr";
    home.homeDirectory = "/home/baykovr";
    home.stateVersion = "23.05"; 
    programs.home-manager.enable = true;

    programs.alacritty = {
      enable = true;
      settings = {
        shell.program = "${pkgs.zsh}/bin/zsh";
        font.size = 14;
      };
    };

    home.packages = [
        pkgs.nixpkgs-fmt
        pkgs.most
        pkgs.fuse
        pkgs.bat
        pkgs.broot
        pkgs.cargo
        pkgs.gnumake
        pkgs.grim
        pkgs.k9s
        pkgs.kubectl
        pkgs.nix-index
        pkgs.ripgrep
        pkgs.rustc
        pkgs.slurp
        pkgs.ssm-session-manager-plugin
        pkgs.terraform
        pkgs.tldr
        pkgs.virtualenv
        pkgs.wlsunset
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;

      extraConfig = lib.fileContents neovim/init.vim;

      plugins = with pkgs.vimPlugins; [
        vim-nix
        gruvbox-material
        nvim-treesitter
        {
          plugin = nvim-colorizer-lua;
          type   = "lua";
          config = builtins.readFile(./neovim/nvim-colorizer-lua.lua);
        }
        {
          plugin = nvim-tree-lua;
          type   = "lua";
          config = builtins.readFile(./neovim/nvim-tree-lua.lua);
        }
      ];
    };
}
