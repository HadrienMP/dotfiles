{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    elmPackages.elm-language-server
    fd
    gnused
    lua54Packages.jsregexp
    typescript-language-server
    nodejs
    python313Packages.pynvim # for nvim-http
    python313Packages.requests # for nvim-http
    ripgrep
    tree-sitter
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
      lazygit-nvim
      vim-nix
    ];
    extraConfig = lib.fileContents ./config/init.lua;
  };
  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
