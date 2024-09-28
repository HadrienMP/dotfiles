{ config, pkgs, lib, ... }:

{
  home.username = "h";
  home.homeDirectory = "/home/h";

  home.packages = with pkgs; [
    _1password
    _1password-gui
    chromium
    gimp
    inkscape
    kooha
    libreoffice-fresh
    logseq
    signal-desktop
  ];
}
