{
  config,
  pkgs,
  ...
}: {
  services.smartd.enable = true;
  services.smartd.autodetect = true;

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

  # TODO: this doesn't work  yet either
  systemd.services.hddtemp = {
    enable = true;
    wantedBy = ["multiuser.target"];
    after = ["network.target"];

    description = "Hard drive temperature monitor daemon";

    serviceConfig = {
      Type = "simple";
      Restart = "on-abort";
      Group = "disk";
      ExecStart = ''${pkgs.hddtemp}/bin/hddtemp -d /dev/sd?'';
    };
  };
}
