{pkgs, lib, ...}: {
    home.username = "baykovr";
    home.homeDirectory = "/home/baykovr";
    home.stateVersion = "23.05"; 
    programs.home-manager.enable = true;

    fonts.fontconfig.enable = true;

    programs.alacritty = {
      enable = true;
      settings = {
        shell.program = "${pkgs.zsh}/bin/zsh";
        font.size = 16;
        import =  ["~/.config/alacritty/themes/themes/solarized_light.yaml"];
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
        pkgs.nerdfonts
        pkgs.nix-output-monitor
        pkgs.ack
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;

      extraConfig = lib.fileContents neovim/init.vim;
      
      plugins = with pkgs.vimPlugins; [
        vim-nix
        gruvbox-material
        vim-terraform
        nvim-web-devicons
        {
          plugin = barbar-nvim;
          type   = "lua";
          config = builtins.readFile(./neovim/barbar.lua);
        }
        vim-commentary
        {
          plugin = pretty-fold-nvim;
          config = ''
            lua require('pretty-fold').setup()
          '';
        }

        nvim-treesitter.withAllGrammars
        {
          plugin = nvim-colorizer-lua;
          config = ''
            packadd! nvim-colorizer.lua
            lua require 'colorizer'.setup()
          '';
        }
        {
          plugin = nvim-tree-lua;
          type   = "lua";
          config = builtins.readFile(./neovim/nvim-tree-lua.lua);
        }
        {
          plugin = toggleterm-nvim;
          type   = "lua";
          config = builtins.readFile(./neovim/toggleterm-nvim.lua);
        }
        coq_nvim
        coq-artifacts
      ];
    };
}
