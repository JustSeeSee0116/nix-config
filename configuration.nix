# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.desktopManager.gnome.enable = true;
  # services.displayManager.gdm.enable = true;

  # To disable installing GNOME's suite of applications
  # and only be left with GNOME shell.
  # services.gnome.core-apps.enable = false;
  # services.gnome.core-developer-tools.enable = false;
  # services.gnome.games.enable = false;
  # environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  programs.niri.enable = true;
  services.greetd = {
    enable = true;
    settings =rec {
      initial_session = {
        command = "${pkgs.dbus}/bin/dbus-run-session ${pkgs.niri}/bin/niri --config /etc/greetd/niri-greeter.kdl";
        user = "greeter";
      };
      default_session = initial_session;
    };
  };
  programs.regreet = {
    enable = true;
  };
  environment.etc."greetd/niri-greeter.kdl".text = ''
    spawn-sh-at-startup "${pkgs.regreet}/bin/regreet; ${pkgs.niri}/bin/niri msg action quit --skip-confirmation"
    hotkey-overlay {
      skip-at-startup
    }
    cursor {
      xcursor-theme "catppuccin-mocha-red-cursors"
    }
  '';
  #config.programs.regreet.package
  users.groups.greeter = {};
  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
    extraGroups = [ "video" ];
    # "input"
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = false;
  # OR
  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  # security.rtkit.enable = true;
  # services.pipewire = {
    #enable = true; # if not already enabled
    #alsa.enable = true;
    #alsa.support32Bit = true;
    #pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  # };

  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  #services.logind.settings.Login = {
  #HandleLidSwitch = "poweroff";
  #HandleLidSwitchExternalPower = "lock";
  #HandleLidSwitchDocked = "ignore";
  #};
  # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"

  #services.thermald.enable = true;

  #programs.auto-cpufreq.enable = true;
  # optionally, you can configure your auto-cpufreq settings, if you have any
  #programs.auto-cpufreq.settings = {
    #charger = {
      #governor = "performance";
      #turbo = "auto";
    #};
    #battery = {
      #governor = "powersave";
      #turbo = "auto";
    #};
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ss = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      #tree
    ];
  };

  # programs.firefox.enable = true;
  # services.flatpak.enable = true;
  
  # nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
      ];
    #extra-substituters = [ "https://noctalia.cachix.org" ];
    #extra-trusted-public-keys = [ "noctalia.cachix.org-1:pC0R47nnMEo5thcxNDtzWp0xNFQsBRglJzxWPp3dkU4=" ];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #wget
    kitty
    fuzzel
    #alacritty
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

