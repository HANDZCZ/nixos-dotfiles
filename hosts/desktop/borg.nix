{ config, pkgs, lib, ... }:

{
  # NOTE: run backup as root, but store everything related to borg in users home
  #       some folders/files can only be read by root and I want them to be backed up,
  #       but all keys to be stored in user's home
  services.borgbackup.jobs = let
    user = "handz";
    user-home = config.home-manager.users.${user}.home.homeDirectory;
  in rec {
    backupHomeToLocalDrive = {
      paths = [ "/home" ];
      doInit = true;
      repo = "/var/lib/borgbackups/nixos-desktop";
      encryption = {
        mode = "keyfile-blake2";
        passphrase = "";
      };
      environment = {
        BORG_BASE_DIR = user-home;
        SERVICE_NAME = "%N";
      };
      compression = "zstd,3";
      startAt = "daily";
      persistentTimer = true;
      extraArgs = [
        "--verbose"
      ];
      extraCreateArgs = [
        "--stats"
        "--keep-exclude-tags"
        "--exclude-caches"
        "--exclude-if-present=.nobackup"
      ];
      prune.keep = {
        daily = 7;
        weekly = 4;
        monthly = 1;
      };
      extraPruneArgs = [
        "--stats"
      ];
      postHook = /* bash */ ''
        # Send notification to user if backup fails
        if [ $exitStatus -ne 0 ]; then
          ${lib.getExe pkgs.sudo} -u ${user} \
            DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(${pkgs.coreutils-full}/bin/id -u ${user})/bus" \
            ${lib.getExe pkgs.libnotify} --urgency critical "Service $SERVICE_NAME failed!" "Run journalctl -u $SERVICE_NAME for details"
        fi
      '';
      exclude = [
        # Caches
        "*/.cache"
        "*/.local/share/Trash"
        "*/Cache"
        "*/CachedData"
        "*/cache"
        "**/.var/app/*/cache"
        "*/.compose-cache"
        # Files
        "**/*.iso"
        "**/*.img"
        "**/*.qcow2"
        # Language specific
        "*/.cargo/registry"
        "*/.cargo/git"
        "*/.rustup"
        # Project specific
        "**/Projects/Rust/**/target"
      ];
    };
    # NOTE: just prepare for remote backup, since remote does not have enough storage space
    /*backupHomeToRemote = lib.recursiveUpdate backupHomeToLocalDrive {
      repo = "borg@10.10.0.25:.";
      environment = {
        # StrictHostKeyChecking fixes root not having destination in known_hosts or having different value
        BORG_RSH = "ssh -o StrictHostKeyChecking=no -i ${user-home}/.ssh/borg/id_ed25519_athena_home";
      };
    };*/
  };
}
