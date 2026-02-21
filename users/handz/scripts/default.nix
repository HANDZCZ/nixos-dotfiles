{ pkgs, config, ... }:

{
  home.packages = [
    (pkgs.callPackage ./ytdl_list_playlist.nix {
      cacheHome = config.xdg.cacheHome;
    })
    (pkgs.callPackage ./fd-list.nix {})
  ];
}
