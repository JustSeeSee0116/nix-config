{
  inputs = {
    # https://mirrors.cernet.edu.cn/nixpkgs.git/ https://mirrors.tuna.tsinghua.edu.cn/git/ github:NixOS/nixpkgs/nixos-25.11
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git/?ref=nixos-unstable&shallow=1";
    nixos-wsl = {
      # https://gitcode.com/gh_mirrors/ni/NixOS-WSL.git/ "github:nix-community/NixOS-WSL/main";
      url = "git+https://git.nju.edu.cn/nix-mirror/NixOS-WSL.git/?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      #url = "github:nix-community/home-manager/release-25.11";
      url = "git+https://git.nju.edu.cn/nix-mirror/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; 
        modules = [
          ./hosts/wsl/configuration.nix
          nixos-wsl.nixosModules.default {
            system.stateVersion = "25.11";
            wsl.enable = true;
            wsl.defaultUser = "nixos";
          }
          home-manager.nixosModules.home-manager 
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nixos = ./home.nix;
            };
          }
        ];
      };
    };    
  };
}
