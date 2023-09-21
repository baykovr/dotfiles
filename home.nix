{pkgs, lib, ...}: {
    home.username = "baykovr";
    home.homeDirectory = "/home/baykovr";
    home.stateVersion = "23.05"; 
    programs.home-manager.enable = true;

    fonts.fontconfig.enable = true;

    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 16;
        shell.program = "${pkgs.zsh}/bin/zsh";
        import =  ["~/.config/alacritty/themes/themes/solarized_light.yaml"];
      };
    };

    home.packages = [
        pkgs.nixpkgs-fmt
        pkgs.most
        pkgs.fuse
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
        pkgs.nodejs
        pkgs.terraform-ls
        pkgs.nixd
        pkgs.nixdoc
      ];

    programs.lazygit = {
        enable = true;
        settings = {
          gui.theme = {
            lightTheme = true;
          };
        };
      };

    programs.bat = {
      enable = true;
      config = {
        theme = "gruvbox-light";
      };
    };

    programs.lf = {
      enable = true;
      settings = {
        icons = true;
        number = true;
      };
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;

      extraConfig = lib.fileContents neovim/init.vim;
      
      plugins = with pkgs.vimPlugins; [
        vim-nix
        gruvbox-material
        vim-terraform
        vim-commentary
        nvim-web-devicons
        { 
          plugin = telescope-nvim;
          type   = "lua";
          config = ''
            require('telescope').setup()
          '';
        }
        {
          plugin = barbar-nvim;
          type   = "lua";
          config = builtins.readFile(./neovim/barbar.lua);
        }
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
        {
          plugin = indent-blankline-nvim;
          type   = "lua";
          config = ''
            require("indent_blankline").setup {
            -- for example, context is off by default, use this to turn it on
            show_current_context = true,
            show_current_context_start = true,
            }
            '';
        }
        coc-nvim
        coc-clangd
      ];
    };
    xdg.configFile = {
      "nvim/coc-settings.json".text = builtins.toJSON {
        "languageserver" = {
          "nixd" = {
            "command" = "nixd";
            "rootPatterns" = [ ".nixd.json" ];
            "filetypes" = [ "nix" ];
          };
          "terraform" = {
            "command" = "terraform-ls";
            "args" = [ "server" ];
            "filestypes" = [ "terraform" "tf" ];
          };
        };
      };
    };
}
