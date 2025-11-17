{ config, pkgs, lib, ... }:

{
  home.username = "h";
  home.homeDirectory = "/home/h";

  home.packages = with pkgs; [
    _1password-cli
    _1password-gui
    audacity
    chromium
    deluge
    gimp
    inkscape
    insomnia
    kooha
    libreoffice-fresh
    logseq
    protonvpn-gui
    pulseaudio
    pulseaudio-ctl
    rhythmbox
    signal-desktop
  ];
}
