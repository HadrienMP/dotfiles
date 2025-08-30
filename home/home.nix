{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.fira-code
    autojump
    btop
    cachix
    devbox
    ffmpeg_6
    fzf
    hugo
    lsd
    mob # Mob.sh
    neofetch
    oh-my-fish
    pom
    slack
    spotify
    termshot
    tldr
    vscode
    xclip
    zoxide

    # ----------------------
    # For NVIM
    # ----------------------
    elmPackages.elm-language-server
    fd
    gnused
    lua54Packages.jsregexp
    nodePackages.typescript-language-server
    ripgrep
    tree-sitter
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
  xdg.configFile."process-compose/shortcuts.yaml".source = ./process-compose/shortcuts.yaml;

  home.shellAliases = {
    ll = "lsd -alh";
  };

  # ---------------------------------------
  # Lazygit
  # ---------------------------------------
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "!";
          context = "global";
          command = "gitmoji -c";
        }
        {
          key = "H";
          context = "localBranches";
          command = "git housekeeping";
        }
      ];
    };
  };


  # ---------------------------------------
  # NVIM
  # ---------------------------------------
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      lazygit-nvim
      vim-nix
    ];
    extraConfig = lib.fileContents nvim/init.lua;
  };
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  # ---------------------------------------
  # Tmux
  # ---------------------------------------
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_middle_separator "\ue0b4 "
        '';
      }
      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          # Smart pane switching with awareness of Vim splits.
          # See: https://github.com/christoomey/vim-tmux-navigator
          is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
              | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"
          bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
          bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
          bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
          bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
          tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
          if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
          if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

          bind-key -T copy-mode-vi 'C-h' select-pane -L
          bind-key -T copy-mode-vi 'C-j' select-pane -D
          bind-key -T copy-mode-vi 'C-k' select-pane -U
          bind-key -T copy-mode-vi 'C-l' select-pane -R
          bind-key -T copy-mode-vi 'C-\' select-pane -l
        '';
      }
    ];
    keyMode = "vi";
    mouse = true;
    sensibleOnTop = false;
    escapeTime = 10;
    baseIndex = 1;
    terminal = "screen-256color";
    clock24 = true;
    prefix = "C-b";
    extraConfig = ''
      set-option -g status-position top

      # Create a new session from the current path
      bind S new-session -c "#{pane_current_path}"

      # Set the path of the current session to the current path
      bind . attach-session -c "#{pane_current_path}"
      
      # Use | to split vertically
      unbind %
      bind | split-window -h

      # Use - to split horizontally
      unbind "\""
      bind "-" split-window -v
    '';
  };

  # ---------------------------------------
  # Tmate
  # ---------------------------------------
  programs.tmate = {
    enable = true;
  };

  # ---------------------------------------
  # Direnv
  # ---------------------------------------
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };


  # ---------------------------------------
  # Git
  # ---------------------------------------
  programs.git = {
    enable = true;
    userName = "hadrienmp";
    userEmail = "github@hadrienmp.fr";
    aliases = {
      co = "checkout";
      s = "status";
      ci = "commit";
      cim = "commit -m";
      ciam = "commit -am";
      a = "add";
      p = "pull";
      push-please = "push --force-with-lease";
      cp = "cherry-pick";
      ls = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'';
      ll = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'';
      hide = "update-index --assume-unchanged";
      unhide = "update-index --no-assume-unchanged";
      show-hidden = "!git ls-files -v | grep '^h' | cut -c3";
      housekeeping = "!git branch --merged | grep -v main | xargs git branch -d";
    };
    extraConfig = {
      core = {
        autocrlf = "input";
        editor = "vim";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "current";
      };
    };
  };

  # ---------------------------------------
  # Ssh
  # ---------------------------------------
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };



  # ---------------------------------------
  # Terminals
  # ---------------------------------------
  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    font = { name = "FiraCode Nerd Font"; };
    settings = {
      confirm_os_window_close = 0;
      wayland_titlebar_color = "background";
      macos_titlebar_color = "background";
    };
  };


  # ---------------------------------------
  # Fish
  # ---------------------------------------

  programs.fish = {
    enable = true;
    plugins = [
      # Need this when using Fish as a default macOS shell in order to pick
      # up ~/.nix-profile/bin
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
          sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
        };
      }
      {
        name = "agnoster";
        src = pkgs.fetchFromGitHub {
          owner = "hauleth";
          repo = "agnoster";
          rev = "7312ebb59769d5ff503fd06b174103f0f7ba368a";
          sha256 = "0/FgJlQULIXKhQIt3z3ugAGubgMlwFZa/cjGjiq7BcA=";
        };
      }
    ];
    shellInit = ''
      # Set syntax highlighting colours; var names defined here:
      # http://fishshell.com/docs/current/index.html#variables-color
      set fish_color_autosuggestion brblack
      set SSH_AUTH_SOCK ~/.1password/agent.sock
      direnv hook fish | source
      fish_add_path $HOME"/.yarn/bin"
      fish_add_path $HOME"/.npm-packages/bin"
      fish_add_path $HOME"/.local/bin"
      zoxide init fish | source
    '';
    shellAliases = {
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";
      ll = "lsd -alh";
    };
  };

  # ---------------------------------------
  # NuShell
  # ---------------------------------------
  programs.nushell = {
    enable = false;
    package = pkgs.nushell;
    extraEnv = ''
      $env.SSH_AUTH_SOCK = '~/.1password/agent.sock'
      $env.PATH = ($env.PATH | split row ':' | prepend $'($env.HOME)/.nix-profile/bin' | prepend '/nix/var/nix/profiles/default/bin')
      $env.PATH = ($env.PATH | prepend $'/run/current-system/sw/bin')
      $env.PATH = ($env.PATH | prepend $'/run/wrappers/bin/')
      $env.XDG_CONFIG_HOME = $'($env.HOME)/.config/'

      zoxide init nushell | save -f ~/.zoxide.nu
      def justtargets [] {just --summary | split row ' '}
      export extern just [target?: string@justtargets, --summary, --list]

      let fish_completer = {|spans|
          fish --command $'complete "--do-complete=($spans | str join " ")"'
          | $"value(char tab)description(char newline)" + $in
          | from tsv --flexible --no-infer
      }
      $env.config.completions.external = {
        enable: true
        max_results: 100
        completer: $fish_completer
      }
    '';
    configFile.source = ./config.nu;
    shellAliases = {
      ll = "ls -als";
    };
  };

  # ---------------------------------------
  # Starship
  # ---------------------------------------
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
  };
  xdg.configFile."starship.toml".source = ./starship.toml;
}





