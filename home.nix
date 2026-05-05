{ config, pkgs, ... }:

{
  home.username = "ss";
  home.homeDirectory = "/home/ss";
  home.packages = with pkgs; [
  ];
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
