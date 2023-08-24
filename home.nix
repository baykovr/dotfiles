{pkgs, ...}: {
    home.username = "baykovr";
    home.homeDirectory = "/home/baykovr";
    home.stateVersion = "23.05"; 
    programs.home-manager.enable = true;
    
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
	    '';

	    plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
        gruvbox-material
        nvim-tree-lua
	    ];
    };
}
