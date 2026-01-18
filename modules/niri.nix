{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    # TODO: change back to stable once version 0.8.0 hits stable
    # fixes: steam crashing on startup, and bringing down with it all other apps dependent on xwayland-sattelite
    #        https://github.com/Supreeeme/xwayland-satellite/issues/282
    #        https://discourse.nixos.org/t/steam-not-launching-in-25-11/73536
    pkgs-unstable.xwayland-satellite
    alacritty
    swayidle
    wev
  ];

  programs.niri.enable = true;
  services.playerctld.enable = true;
}
