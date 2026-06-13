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
    proton-vpn
    pulseaudio
    pulseaudio-ctl
    rhythmbox
    signal-desktop
    sysstat # for tmux cpu
  ];


  programs.ssh.matchBlocks."*".extraOptions.IdentityAgent = "~/.1password/agent.sock";
}
