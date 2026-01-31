# stolen from https://github.com/fufexan/nix-gaming/blob/e159b12c7169fb0858cda678fdf6d10f00595091/modules/ntsync.nix
{ pkgs, config, lib, ...}:

{
  options.kernel.ntsync.enable = lib.mkEnableOption "ntsync. Only avaliable on Linux 6.14+.";

  config = lib.mkIf config.kernel.ntsync.enable {
    # load ntsync
    boot.kernelModules = [ "ntsync"];

    # make ntsync device accessible
    services.udev.packages = [
      (pkgs.writeTextFile {
        name = "ntsync-udev-rules";
        text = ''KERNEL=="ntsync", MODE="0660", TAG+="uaccess"'';
        destination = "/etc/udev/rules.d/70-ntsync.rules";
      })
    ];

    assertions = [
      {
        assertion = lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.14";
        message = "Option `kernel.ntsync.enable` requires Linux 6.14+.";
      }
    ];
  };
}
