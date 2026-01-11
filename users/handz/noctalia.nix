{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/noctalia.nix
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
  };
}
