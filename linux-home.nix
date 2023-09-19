{ config, pkgs, lib, ... }:

{
  home.username = "h";
  home.homeDirectory = "/home/h";

  home.packages = with pkgs; [
    gimp
    inkscape
    kooha
    whatsapp-for-linux
    tidal-hifi
    libreoffice-fresh
  ];
}
