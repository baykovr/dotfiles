{pkgs, ...}: {
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
    ];

    programs.neovim = {
      enable = true;
	    defaultEditor = true;
	    extraConfig = ''
	      set nocompatible
	      set termguicolors
	      syntax on
	      filetype plugin indent on

	      set number
	      set ttyfast
	      set cursorline

	      set autoindent expandtab tabstop=2 shiftwidth=2

        colorscheme gruvbox-material
        set background=light

        """ Key Map
        map <F3> :NvimTreeToggle<CR>
	    '';

	    plugins = with pkgs.vimPlugins; [
        gruvbox-material
        nvim-tree-lua
        {
          plugin = nvim-tree-lua;
          type   = "lua";
          config = builtins.readFile(./neovim/nvim-tree-lua.lua);
        }
      ];
    };
}
