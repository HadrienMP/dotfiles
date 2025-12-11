{ config, pkgs, system, inputs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    font = { name = "FiraMono Nerd Font"; };
    settings = {
      confirm_os_window_close = 0;
      wayland_titlebar_color = "background";
      macos_titlebar_color = "background";
      disable_ligatures = "never";
      hide_window_decorations = "yes";
    };
  };
}
