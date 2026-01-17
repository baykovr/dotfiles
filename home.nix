{pkgs, lib, ...}: {
    home.username = "baykovr";
    home.homeDirectory = "/Users/baykovr";
    home.stateVersion = "23.05"; 
    programs.home-manager.enable = true;

    fonts.fontconfig.enable = true;
    home.packages = import ./packages.nix { pkgs = pkgs; };

    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 18;
        shell.program = "${pkgs.zsh}/bin/zsh";
        #import =  ["~/.config/alacritty/themes/themes/solarized_light.yaml"];
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

    programs.tmux = {
      enable = true;
      historyLimit = 1000000;
      prefix = "C-Space";
      extraConfig = ''
        # Use ~ as prefix
        unbind C-b
        set -g prefix `
        bind ` send-prefix

        # Status bar on top
        set -g status-position top

        # Orange background, white foreground
        set -g status-style 'bg=colour208 fg=white'

        # ~ t = new window, ~ w = close window
        bind t new-window
        bind w kill-window
      '';
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

    # programs.vscode = {
    #   enable = true;
    #   package = pkgs.vscode.fhs;
    # };

    programs.neovim = import ./neovim/neovim.nix { pkgs=pkgs; lib=lib; };

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
