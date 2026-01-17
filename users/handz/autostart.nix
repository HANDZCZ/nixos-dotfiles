{ config, lib, pkgs, ... }:

let
  nixcord = config.programs.nixcord;

  mkEntry = name: command:
    pkgs.makeDesktopItem {
      desktopName = "${name}-autostart";
      name = "${name}-autostart";
      exec = "${command}";
      destination = "/";
    } + "/${name}-autostart.desktop";
  mkCondEntry = condition: name: command: lib.mkIf condition (mkEntry name command);
in {
  xdg.autostart = {
    enable = true;
    entries = [
      (mkCondEntry (nixcord.enable && nixcord.discord.enable) "Discord" "discord --start-minimized")
      (mkCondEntry (lib.elem pkgs.qbittorrent config.home.packages) "qBittorrent" "qbittorrent --confirm-legal-notice")
    ];
  };
}
