{ config, pkgs, lib, ... }:

{
  home.username = "h";
  home.homeDirectory = "/home/h";

  home.packages = with pkgs; [
    _1password-cli
    _1password-gui
    audacity
    chromium
    gimp
    inkscape
    kooha
    libreoffice-fresh
    logseq
    pulseaudio
    pulseaudio-ctl
    signal-desktop
    rhythmbox
  ];
}
