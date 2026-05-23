{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.packages = with pkgs; [
  ];
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };
  home.stateVersion = "25.11";
}
