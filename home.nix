{pkgs, lib, username, homeDir, isDarwin, ...}: {
    home.username = username;
    home.homeDirectory = homeDir;
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    fonts.fontconfig.enable = true;
    home.packages = import ./packages.nix { inherit pkgs isDarwin; };

    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 18;
        shell.program = "${pkgs.zsh}/bin/zsh";
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
      extraConfig = ''
        # Use ` as prefix
        unbind C-b
        set -g prefix `
        bind ` send-prefix

        # Status bar on top
        set -g status-position top

        # Orange background, white foreground
        set -g status-style 'bg=colour208 fg=white'

        # ` t = new window, ` w = close window
        bind t new-window
        bind w kill-window

        # ` | = vertical split, ` - = horizontal split
        bind | split-window -h
        bind - split-window -v
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

    programs.vscode = lib.mkIf (!isDarwin) {
      enable = true;
      package = pkgs.vscode.fhs;
    };

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
