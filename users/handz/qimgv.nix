{ lib, pkgs-unstable, ... }:

{
  home.packages = [ pkgs-unstable.qimgv ];

  xdg.mimeApps.defaultApplications = lib.genAttrs [
    "image/png"
    "image/jpeg"
    "image/webp"
    "image/gif"
    "image/bmp"
  ]  (_: "qimgv.desktop");

  xdg.configFile."qimgv/qimgv.conf" = {
    text = lib.generators.toINI {} {
      General = {
        JPEGSaveQuality = 100;
        infoBarWindowed = true;
        playVideoSounds = true;
        zoomIndicatorMode = 1;
      };
    };
  };
}
