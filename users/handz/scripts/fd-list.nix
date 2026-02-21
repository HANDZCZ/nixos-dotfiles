{ pkgs, lib, ... }:

pkgs.writeShellScriptBin "fd-list" ''
  ${lib.getExe pkgs.fd} $@ -X ${lib.getExe pkgs.eza} -dlag --icons -s type {};
''
