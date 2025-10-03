{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    elmPackages.elm-language-server
    fd
    gnused
    lua54Packages.jsregexp
    nodePackages.typescript-language-server
    ripgrep
    tree-sitter
  ];

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
}
