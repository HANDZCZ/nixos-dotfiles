{ lib, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.packages = with pkgs; [
    adw-gtk3
  ];

  gtk = {
    enable = true;
    theme = {
      name = lib.mkDefault "adw-gtk3-dark";
      package = lib.mkDefault pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = lib.mkDefault "gtk";
    style.name = lib.mkDefault "adwaita-dark";
  };
}
