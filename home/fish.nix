{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [
      # Need this when using Fish as a default macOS shell in order to pick
      # up ~/.nix-profile/bin
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
          sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
        };
      }
      {
        name = "agnoster";
        src = pkgs.fetchFromGitHub {
          owner = "hauleth";
          repo = "agnoster";
          rev = "7312ebb59769d5ff503fd06b174103f0f7ba368a";
          sha256 = "0/FgJlQULIXKhQIt3z3ugAGubgMlwFZa/cjGjiq7BcA=";
        };
      }
    ];
    shellInit = ''
      # Set syntax highlighting colours; var names defined here:
      # http://fishshell.com/docs/current/index.html#variables-color
      set fish_color_autosuggestion brblack
      set SSH_AUTH_SOCK ~/.1password/agent.sock
      direnv hook fish | source
      fish_add_path $HOME"/.yarn/bin"
      fish_add_path $HOME"/.npm-packages/bin"
      fish_add_path $HOME"/.local/bin"
      zoxide init fish | source
    '';
    shellAliases = {
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";
      ll = "lsd -alh";
    };
  };
}





