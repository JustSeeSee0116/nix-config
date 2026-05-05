{ config, pkgs, ... }:

{
  home.username = "ss";
  home.homeDirectory = "/home/ss";
  home.packages = with pkgs; [
  ];
  xdg.configFile."niri/config.kdl".text = ''
    spawn-at-startup "noctalia-shell"
    window-rule {
      // Rounded corners for a modern look.
      geometry-corner-radius 20

      // Clips window contents to the rounded corner boundaries.
      clip-to-geometry true
    }

    debug {
      // Allows notification actions and window activation from Noctalia.
      honor-xdg-activation-with-invalid-serial
    }
  '';
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
