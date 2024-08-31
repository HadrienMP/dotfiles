{ config, pkgs, lib, ... }:

{
  home.username = "h";
  home.homeDirectory = "/home/h";

  home.packages = with pkgs; [
    gimp
    inkscape
    kooha
    libreoffice-fresh
    # logseq
    signal-desktop
  ];
}
