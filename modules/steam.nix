{ inputs, pkgs, pkgs-unstable, ... }:

{
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  environment.systemPackages = with pkgs; [
    mangohud
  ];

  programs = {
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs-unstable.proton-ge-bin ];
      platformOptimizations.enable = true;
      protontricks.enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
    gamemode = {
      enable = true;
      enableRenice = true;
    };
  };
}
