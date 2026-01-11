{ pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/prefer-dark.nix
    ./noctalia.nix
    ./nixcord.nix
    ./git.nix
    ./bash.nix
  ];

  home.username = "handz";
  home.homeDirectory = "/home/handz";
  home.stateVersion = "25.11";

  programs.lazygit = {
    enable = true;
    settings = {
      git.commit.autoWrapCommitMessage = false;
    };
  };

  home.packages = with pkgs; [
    btop
    htop
    brave
  ];
}
