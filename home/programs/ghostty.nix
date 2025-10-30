{ config, pkgs, inputs, system, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages."${system}".default;
    enableFishIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      font-family = "Fira Code";
      font-feature = "+calt +liga, +dlig";
      theme = "Dracula";
      window-decoration = "none";
    };
  };
}
