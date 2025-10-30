{ config, pkgs, system, inputs, lib, ... }:

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
    nerd-fonts.fira-mono
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
    inputs.bootstrap-kata.packages."${system}".bootstrap-kata
    inputs.zen-browser.packages."${system}".beta
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
  # Direnv
  # ---------------------------------------
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  # ---------------------------------------
  # Ssh
  # ---------------------------------------
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      extraOptions = {
        IdentityAgent = "~/.1password/agent.sock";
      };
    };
  };



  # ---------------------------------------
  # Terminals
  # ---------------------------------------
  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    font = { name = "FiraMono Nerd Font"; };
    settings = {
      confirm_os_window_close = 0;
      wayland_titlebar_color = "background";
      macos_titlebar_color = "background";
      disable_ligatures = "never";
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





