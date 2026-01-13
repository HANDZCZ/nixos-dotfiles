{ inputs, lib, pkgs, ...}:

{
  imports = [
    inputs.nix-gaming.nixosModules.wine
  ];

  programs.wine = {
    enable = true;
    package = lib.mkDefault pkgs.wine-ge;
    ntsync = true;
  };
}
