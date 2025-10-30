{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      alias = {
        co = "checkout";
        s = "status";
        ci = "commit";
        cim = "commit -m";
        ciam = "commit -am";
        a = "add";
        p = "pull";
        push-please = "push --force-with-lease";
        cp = "cherry-pick";
        ls = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'';
        ll = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'';
        hide = "update-index --assume-unchanged";
        unhide = "update-index --no-assume-unchanged";
        show-hidden = "!git ls-files -v | grep '^h' | cut -c3";
        housekeeping = "!git branch --merged | grep -v main | xargs git branch -d";
      };
      core = {
        autocrlf = "input";
        editor = "vim";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "current";
      };
      user = {
        name = "hadrienmp";
        email = "github@hadrienmp.fr";
      };
    };
  };
}

