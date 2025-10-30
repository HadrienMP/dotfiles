{ config, pkgs, inputs, system, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages."${system}".default;
    enableFishIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      font-family = "FiraMono Nerd Font";
      theme = "Dracula";
      window-decoration = "none";
    };
  };
}
