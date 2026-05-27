{
  inputs = {
    # https://mirrors.cernet.edu.cn/nixpkgs.git/ https://mirrors.tuna.tsinghua.edu.cn/git/ github:NixOS/nixpkgs/nixos-25.11
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    # impermanence.url = "github:nix-community/impermanence";
    impermanence = {
      url = "git+https://git.nju.edu.cn/nix-mirror/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    home-manager = {
      #url = "github:nix-community/home-manager/release-25.11";
      url = "git+https://git.nju.edu.cn/nix-mirror/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, impermanence, home-manager, ... }@inputs: { 
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; 
        modules = [
          ./configuration.nix
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager 
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ss = ./home.nix;
            };
          }
        ];
      };
    };    
  };
}
