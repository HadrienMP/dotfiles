{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ash";
  home.homeDirectory = "/Users/ash";

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
    lsd
    oh-my-fish
    fzf
    docker
    gcc
    # postman
    ngrok
    hugo
    nodejs
    mob
    dbeaver
    _1password-gui
    _1password
    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
    xclip
    neofetch
    nodePackages.degit

    # ----------------------
    # For NVIM
    # ----------------------
    lazygit
    tree-sitter
    ripgrep
    fd
    elmPackages.elm-language-server
    nodePackages.typescript-language-server
    gnused
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  home.shellAliases = {
    ll = "lsd -alh";
  };

  # ---------------------------------------
  # Lazygit
  # ---------------------------------------
  programs.lazygit = {
    enable = true;
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
      resurrect
      continuum
      power-theme
    ];
    extraConfig = ''
      # Mouse works as expected
      set-option -g mouse on

      set -g @continuum-restore 'on'
      set -g @continuum-boot 'on'
      set -g status-right 'Continuum status: #{continuum_status}'

      set-option -sg escape-time 10
      set-option -g default-terminal "screen-256color"
      set-option -sa terminal-overrides ',XXX:RGB'

      set -g @tmux_power_theme 'violet'
    '';
  };

  # ---------------------------------------
  # Tmate
  # ---------------------------------------
  programs.tmate = {
    enable = true;
    extraConfig = ''
      if-shell "test -f ~/.tmux-status.conf" "source ~/.tmux-status.conf"
    '';
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
    };
    extraConfig = {
      core = {
        autocrlf = "input";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
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
  # Fish
  # ---------------------------------------
  programs.kitty = {
    enable = true;
    theme = "Dracula";
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
      agnoster powerline
    '';
    shellAliases = {
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";
      ll = "lsd -alh";
    };
  };
}
