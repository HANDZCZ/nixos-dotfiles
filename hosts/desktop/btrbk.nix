{ config, ... }:

let
  data_btrfs_pool = "/run/btrfs_pools/data";
in {
  services.btrbk.instances = {
    "dataDrive" = {
      onCalendar = "hourly";
      settings = {
        volume.${data_btrfs_pool} = {
          subvolume = "home";
          snapshot_dir = "snapshots";
        };

        timestamp_format = "long";
        snapshot_create = "onchange";

        snapshot_preserve_min = "1w";
        snapshot_preserve = "7d 4w 1m";
      };
    };
  };

  assertions = [{
    assertion = config.fileSystems."/home".fsType == "btrfs";
    message = "Btrbk: Expected '/home' mount to be btrfs filesystem";
  }];

  fileSystems.${data_btrfs_pool} = {
    device = config.fileSystems."/home".device;
    fsType = "btrfs";
  };
}
