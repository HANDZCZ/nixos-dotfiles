{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-compat.url = "github:NixOS/flake-compat";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
      };
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://attic.xuyh0120.win/lantian" # nix-cachyos-kernel
    ];
    extra-trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" # nix-cachyos-kernel
    ];
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }: {
    nixosConfigurations = {
      nixos-desktop =
        let
          system = "x86_64-linux";
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
          };
        in nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [ ./hosts/desktop ];
        };
    };
  };
}
