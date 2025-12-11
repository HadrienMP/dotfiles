{ config, pkgs, lib, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "!";
          context = "global";
          command = "gitmoji -c";
        }
        {
          key = "H";
          context = "localBranches";
          command = "git housekeeping";
        }
      ];
    };
  };
}
