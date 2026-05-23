{ config, lib, pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
      ];
    extra-substituters = [ 
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [ 
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  networking.hostName = "nixos";
  time.timeZone = "Asia/Shanghai";
  programs.niri = {
    enable = true;
    #useNautilus = false;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    kitty
    fuzzel
  ];
  system.stateVersion = "25.11";
}

