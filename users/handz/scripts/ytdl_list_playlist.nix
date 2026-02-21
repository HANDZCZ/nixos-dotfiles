{
  lib,
  pkgs,
  cacheHome ? "~/.cache",
  cacheDir ? "${cacheHome}/youtube-dl",
}:

pkgs.writeShellScriptBin "ytdl_list_playlist" ''
  ${lib.getExe pkgs.yt-dlp} --ignore-errors --no-mark-watched --flat-playlist --geo-bypass --yes-playlist --cache-dir ${cacheDir} --get-title --get-duration $@ | ${lib.getExe pkgs.gnused} -r 'N;s/(.*)\n(.*)/\2 - \1/'
''
