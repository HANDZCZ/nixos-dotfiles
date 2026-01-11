{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/noctalia.nix
    ../../modules/home-manager/noctalia-theming.nix
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
  };
}
