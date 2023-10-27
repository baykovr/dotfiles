{pkgs, lib, ...}: {
    home.username = "baykovr";
    home.homeDirectory = "/home/baykovr";
    home.stateVersion = "23.05"; 
    programs.home-manager.enable = true;

    fonts.fontconfig.enable = true;
    home.packages = import ./packages.nix { pkgs = pkgs; };

    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 18;
        shell.program = "${pkgs.zsh}/bin/zsh";
        import =  ["~/.config/alacritty/themes/themes/solarized_light.yaml"];
      };
    };
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
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
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
            require("ibl").setup {}
            '';
        }
        {
          plugin = galaxyline-nvim;
          type = "lua";
          config = ''
            local gl = require('galaxyline')
            local condition = require('galaxyline.condition')
            local gls = gl.section
            require('galaxyline').section.left[1] = {
              FileSize = {
                provider = 'FileSize',
                condition = condition.buffer_not_empty,
                icon = '   ',
                separator = '',
                highlight = { "#f8DDA8", "#2e2e2e"},
                separator_highlight = { "#ebb450", "#2e2e2e"}
              },
              LineInfo = {
                provider = 'LineColumn',
                separator = ' ',
                highlight = { "#f8DDA8", "#2e2e2e"},
                separator_highlight = { "#ebb450", "#2e2e2e"}
              },
            }
           '';
        }
        coc-nvim
        coc-clangd
        coc-pyright
        coc-sh
        coc-go
        coc-yaml
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
