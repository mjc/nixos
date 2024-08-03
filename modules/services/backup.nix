{...}: {
  # sanoid for snapshotting
  services.sanoid = {
    enable = true;
    templates.backup = {
      hourly = 14;
      daily = 7;
      monthly = 1;
      autoprune = true;
      autosnap = true;
    };

    datasets = {
      "wonderland/backup".useTemplate = ["backup"];
      "wonderland/backup".recursive = true;
      "zroot/home".useTemplate = ["backup"];
      "zroot/home".recursive = true;
      "zroot/root".useTemplate = ["backup"];
      "zroot/root".recursive = true;
      "zroot/var".useTemplate = ["backup"];
      "zroot/var".recursive = true;
    };
  };

  # syncoid for copying
  # services.syncoid = {
  #   enable = true;
  #   commonArgs = [
  #     "--recursive"
  #   ];
  #   commands = {
  #     "wonderland/backup".target = "backup/synced/backup";
  #     "wonderland/home".target = "backup/synced/tina/home";
  #     "wonderland/root".target = "backup/synced/tina/root";
  #     "wonderland/var".target = "backup/synced/tina/var";
  #     "wonderland/media/family".target = "backup/synced/tina/family";
  #   };
  #   localSourceAllow = [
  #     "bookmark"
  #     "hold"
  #     "send"
  #     "snapshot"
  #     "destroy"
  #     "mount"
  #   ];
  #   localTargetAllow = [
  #     "compression"
  #     "create"
  #     "mount"
  #     "mountpoint"
  #     "receive"
  #     "rollback"
  #     "destroy"
  #   ];
  # };
}
