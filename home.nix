{ config, pkgs, ... }:

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
    postman
  ];

  home.shellAliases = {
    ll = "lsd -alh";
  };

  # ---------------------------------------
  # VIM
  # ---------------------------------------
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
      vim-airline
      vim-nix
      nerdtree
      dracula-vim
      vim-devicons
      tmuxline-vim
    ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
      set nocompatible
      set nowrap
      set encoding=utf8
      set expandtab
      set smarttab
      set shiftwidth=4
      set tabstop=4
      set ai "Auto indent
      set si "Smart indent
      set ruler
      set laststatus=2
      syntax on
      
      set nu
      autocmd vimenter * NERDTree
      let NERDTreeShowHidden=1
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      " Go to previous (last accessed) window.
      autocmd VimEnter * wincmd p

      " Airline configuration
      let g:airline#extensions#tabline#enabled = 1
      let g:airline_powerline_fonts = 1
      let g:airline_theme='luna'
      let g:hybrid_custom_term_colors = 1
      let g:hybrid_reduced_contrast = 1
      set t_Co=256
      let g:airline#extensions#tmuxline#enabled = 1
      let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"
    '';
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
