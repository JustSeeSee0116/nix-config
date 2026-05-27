{ config, pkgs, ... }:

{
  home.username = "ss";
  home.homeDirectory = "/home/ss";
  home.packages = with pkgs; [
  ];
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };
  home.stateVersion = "25.11";
}
