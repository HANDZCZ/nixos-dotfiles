{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "Vanilla-DMZ";
    size = 32;
    package = pkgs.vanilla-dmz;
  };
}
