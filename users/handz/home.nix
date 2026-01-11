{ pkgs, ... }:

{
  imports = [
    ./noctalia.nix
    ./bash.nix
  ];

  home.username = "handz";
  home.homeDirectory = "/home/handz";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    btop
    htop
    brave
  ];
}
