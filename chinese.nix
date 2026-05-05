{ config, pkgs, lib, ... }:

{
  i18n = {
    #defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
   };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
    fcitx5-chinese-addons
    fcitx5-gtk
   ];
   fcitx5.waylandFrontend = true;
  };

  fonts = {
  packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans    
    noto-fonts-cjk-serif   
    ];
  fontconfig = {
    defaultFonts = {
      sansSerif = [ "Noto Sans CJK SC" ];
      serif = [ "Noto Serif CJK SC" ];
     };
   };
 };
}
