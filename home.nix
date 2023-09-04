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
    lsd
    oh-my-fish
    fzf
    docker
    gcc
    postman
    vscode
    ngrok
    hugo
    nodejs
    mob # Mob.sh
    dbeaver
    _1password-gui
    _1password
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    xclip
    neofetch
    nodePackages.degit
    nodePackages.gitmoji-cli
    cachix
    fd
    autojump
    zoxide
    ffmpeg_6
    discord
    devbox

    # ----------------------
    # For Spacemacs
    # ----------------------
    emacs
    gnutar

    # ----------------------
    # For NVIM
    # ----------------------
    tree-sitter
    ripgrep
    fd
    elmPackages.elm-language-server
    nodePackages.typescript-language-server
    gnused
    lua54Packages.jsregexp
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
    settings = {
      customCommands = [
        {
          key = "!";
          context = "global";
          command = "gitmoji -c";
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
        plugin = power-theme;
        extraConfig = ''
          set -g @tmux_power_theme '#80abf6' 
          set -g @tmux_power_left_arrow_icon ''
          set -g @tmux_power_right_arrow_icon ''
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
    theme = "Dracula";
    font = { name = "FiraCode Nerd Font"; };
  };


  # ---------------------------------------
  # Spacemacs
  # ---------------------------------------
  home.file.".emacs.d" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "syl20bnr";
      repo = "spacemacs";
      rev = "26629bf3a5b8d0228be23827bb86dbd8d8087378";
      sha256 = "sha256-SYYbUHomnYE99tdmfxA/3xVhb/F5AD13bTbcxpesO2s=";
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
      agnoster powerline
      set -U AGNOSTER_SEGMENT_SEPARATOR '' '  '
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
    enable = true;
    extraEnv = ''
      $env.AUTOJUMP_ERROR_PATH = '/Users/ash/Library/autojump/errors.log'
      $env.AUTOJUMP_SOURCED = '1'
      $env.CMD_DURATION_MS = '0823'
      $env.COLORFGBG = '15;0'
      $env.COLORTERM = 'truecolor'
      $env.COMMAND_MODE = 'unix2003'
      $env.DIRS_LIST = '[/Users/ash]'
      $env.DIRS_POSITION = '0'
      $env.HOME = '/Users/ash'
      $env.LANG = 'fr_FR.UTF-8'
      $env.LAST_EXIT_CODE = '0'
      $env.LOGNAME = 'ash'
      $env.LOG_ANSI = '{CRITICAL: , ERROR: , WARNING: , INFO: , DEBUG: }'
      $env.LOG_FORMAT = '%ANSI_START%%DATE%|%LEVEL%|%MSG%%ANSI_STOP%'
      $env.LOG_LEVEL = '{CRITICAL: 50, ERROR: 40, WARNING: 30, INFO: 20, DEBUG: 10}'
      $env.LOG_PREFIX = '{CRITICAL: CRT, ERROR: ERR, WARNING: WRN, INFO: INF, DEBUG: DBG}'
      $env.LOG_SHORT_PREFIX = '{CRITICAL: C, ERROR: E, WARNING: W, INFO: I, DEBUG: D}'
      $env.LS_COLORS = 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:'
      $env.LaunchInstanceID = '6E438EEE-5D7A-432A-824E-9CA543624402'
      $env.NIX_LINK_NEW = '/Users/ash/.local/state/nix/profile'
      $env.NIX_PATH = '/Users/ash/.nix-defexpr/channels:darwin-config=/Users/ash/.nixpkgs/darwin-configuration.nix:/nix/var/nix/profiles/per-user/root/channels'
      $env.NIX_PROFILES = '/nix/var/nix/profiles/default /Users/ash/.nix-profile'
      $env.NIX_REMOTE = 'daemon'
      $env.NIX_SSL_CERT_FILE = '/etc/ssl/certs/ca-certificates.crt'
      $env.NIX_USER_PROFILE_DIR = '/nix/var/nix/profiles/per-user/ash'
      $env.OSTYPE = 'darwin22.5.0'
      $env.PAGER = 'less -R'
      $env.PATH = '[/nix/var/nix/profiles/default/bin, /Users/ash/.nix-profile/bin, /Users/ash/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/opt/homebrew/opt/libxml2/bin:/Users/ash/.local/bin:/Users/ash/.npm-packages/bin:/Users/ash/.yarn/bin:/Users/ash/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/opt/homebrew/bin:/Users/ash/.fzf/bin:/run/current-system/sw/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin]'
      $env.PROMPT_COMMAND = '<Closure 1608>'
      $env.PROMPT_COMMAND_RIGHT = '<Closure 1613>'
      $env.PROMPT_INDICATOR = \'\'
      $env.PROMPT_MULTILINE_INDICATOR = '∙ '
      $env.SECURITYSESSIONID = '186b5'
      $env.SHLVL = '2'
      $env.SSH_AUTH_SOCK = '/Users/ash/.1password/agent.sock'
      $env.STARSHIP_SESSION_KEY = 't6BjmA88Ugi7AxxU'
      $env.STARSHIP_SHELL = 'nu'
      $env.USER = 'ash'
      $env.XDG_CONFIG_DIRS = '/Users/ash/.nix-profile/etc/xdg:/run/current-system/sw/etc/xdg:/nix/var/nix/profiles/default/etc/xdg'
      $env.XDG_DATA_DIRS = '/Users/ash/.nix-profile/share:/run/current-system/sw/share:/nix/var/nix/profiles/default/share'
      $env.XPC_FLAGS = '0x0'
      $env.XPC_SERVICE_NAME = '0'
      $env.__CFBundleIdentifier = 'com.googlecode.iterm2'
      $env.__CF_USER_TEXT_ENCODING = '0x1F5:0x0:0x1'
      $env.__ETC_ZSHENV_SOURCED = '1'
      $env.__HM_SESS_VARS_SOURCED = '1'
      $env.__NIX_DARWIN_SET_ENVIRONMENT_DONE = '1'

      zoxide init nushell | save -f ~/.zoxide.nu
    '';
    extraConfig = ''
      source ~/.zoxide.nu
    '';
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





