{
  config,
  pkgs,
  lib,
  ...
}: {
  services.smartd.enable = true;
  services.smartd.autodetect = true;

  hardware.sensor.hddtemp = {
    enable = true;
    drives = lib.mkDefault ["/dev/sd?" "/dev/nvme*"];
    unit = "C";
  };

  services.zfs = {
    expandOnBoot = ["wonderland"];

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
}
