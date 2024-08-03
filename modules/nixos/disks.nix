{lib, ...}: {
  services.smartd.enable = true;
  services.smartd.autodetect = true;

  hardware.sensor.hddtemp = {
    enable = true;
    drives = lib.mkDefault ["/dev/sd?"];
    unit = "C";
  };

  services.zfs = {
    expandOnBoot = ["wonderland" "backup"];

    autoScrub = {
      enable = true;
      interval = "monthly";
    };
    trim = {
      enable = true;
      interval = "daily";
    };
    autoSnapshot = {
      enable = true;
    };
  };

  boot.extraModprobeConfig = ''
    options zfs zfs_arc_max=34359738368
  '';
  boot.zfs.extraPools = ["backup" "wonderland"];
}
