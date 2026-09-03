{ config, pkgs, system, inputs, lib, ... }:

{
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop
    cachix
    darktable
    deluge
    devbox
    docker
    fastfetch
    ffmpeg
    fira-code
    fzf
    hugo
    inputs.bootstrap-kata.packages."${system}".bootstrap-kata
    inputs.zen-browser.packages."${system}".beta
    keymapp
    lsd
    mise
    mob # Mob.sh
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
    yt-dlp
    zapzap #whatsapp client
    zoxide
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."nixpkgs/config.nix".source = ./config/nixpkgs-config.nix;
  xdg.configFile."process-compose/shortcuts.yaml".source = ./config/process-compose/shortcuts.yaml;

  home.shellAliases = {
    ll = "lsd -alh";
  };

  services.colima = {
    enable = true;
  };
}
