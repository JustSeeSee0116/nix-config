{ self, inputs, ... }: {

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.ss = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.myHomeManager
      {
        home.username = "ss";
        home.homeDirectory = "/home/ss";
      }
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules.myHomeManager = { pkgs, ... }: {
    #programs.bash.enable = true;
    #rograms.bash.shellAliases.ll = "ls -l";

    home.packages = with pkgs; [
    ];
    xdg.configFile."niri/config.kdl" = {
      source = ./config.kdl;
      force = true;
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "25.11";
  };
}
