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
    tmate
    fzf
    docker
    # postman
    ngrok
    hugo
    nodejs
    mob
    # ----------------------
    # For NVIM
    # ----------------------
    lazygit
    tree-sitter
    ripgrep
    fd
    elmPackages.elm-language-server
    nodePackages.typescript-language-server
  ];

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  home.shellAliases = {
    ll = "lsd -alh";
  };

  # ---------------------------------------
  # Lazygit
  # ---------------------------------------
  programs.lazygit = {
    enable = true;
    settings =
      {
        customCommands = [

          {
            key = "Z";
            command = "git cz";
            context = "files";
            loadingText = "opening commitizen commit tool";
            subprocess = true;
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
      resurrect
      continuum
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
