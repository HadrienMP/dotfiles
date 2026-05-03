{ config, pkgs, system, inputs, lib, ... }:

{
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop
    cachix
    colima
    deluge
    devbox
    ffmpeg_6
    fira-code
    fzf
    hugo
    inputs.bootstrap-kata.packages."${system}".bootstrap-kata
    inputs.zen-browser.packages."${system}".beta
    lsd
    mise
    mob # Mob.sh
    neofetch
    nerd-fonts._0xproto
    nerd-fonts.fira-mono
    oh-my-fish
    pom
    slack
    spotify
    termshot
    tldr
    vscode
    xclip
    zoxide
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."nixpkgs/config.nix".source = ./config/nixpkgs-config.nix;
  xdg.configFile."process-compose/shortcuts.yaml".source = ./config/process-compose/shortcuts.yaml;

  home.shellAliases = {
    ll = "lsd -alh";
  };
}
