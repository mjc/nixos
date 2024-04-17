{
  config,
  pkgs,
  ...
}: {
  services.smartd.enable = true;
  services.smartd.autodetect = true;

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

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
