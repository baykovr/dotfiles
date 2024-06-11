{pkgs, lib}:
{
    enable = true;
    defaultEditor = true;

    extraConfig = lib.fileContents ./init.vim;
    
    plugins = with pkgs.vimPlugins; [
      gruvbox-material
      everforest
      rose-pine

      vim-nix
      vim-terraform
      vim-commentary

      nvim-web-devicons
      {
        plugin = plenary-nvim;
        type   = "lua";
      }
      { 
        plugin = telescope-nvim;
        type   = "lua";
        config = ''
          require('telescope').setup{
            pickers = {
              colorscheme = {
                enable_review = true 
              }
            }
          }
        '';
      }
      {
        plugin = barbar-nvim;
        type   = "lua";
        config = builtins.readFile(./barbar.lua);
      }
      {
        plugin = pretty-fold-nvim;
        config = ''
          lua require('pretty-fold').setup()
        '';
      }
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
        config = builtins.readFile(./nvim-tree-lua.lua);
      }
      {
        plugin = toggleterm-nvim;
        type   = "lua";
        config = builtins.readFile(./toggleterm-nvim.lua);
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
}

