{ pkgs, osConfig, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      # no wayland support for now
      #input-overlay
      obs-dvd-screensaver
      obs-pipewire-audio-capture
      wlrobs
    ];
    package = pkgs.obs-studio.override {
      cudaSupport = osConfig.hardware.nvidia.enabled;
    };
  };
}
