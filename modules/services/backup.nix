{...}: {
  # sanoid for snapshotting
  services.sanoid = {
    enable = true;
    templates.backup = {
      hourly = 36;
      daily = 30;
      monthly = 3;
      autoprune = true;
      autosnap = true;
    };

    datasets = {
      "wonderland/backup".useTemplate = ["backup"];
      "wonderland/backup".recursive = true;
      "wonderland/home".useTemplate = ["backup"];
      "wonderland/home".recursive = true;
      "wonderland/root".useTemplate = ["backup"];
      "wonderland/root".recursive = true;
      "wonderland/var".useTemplate = ["backup"];
      "wonderland/var".recursive = true;
    };
  };

  # syncoid for copying
  services.syncoid = {
    enable = true;
    commonArgs = [
      "--recursive"
      "--no-stream"
    ];
    commands = {
      "wonderland/backup".target = "backup/synced/backup";
      "wonderland/home".target = "backup/synced/tina/home";
      "wonderland/root".target = "backup/synced/tina/root";
      "wonderland/var".target = "backup/synced/tina/var";
    };
    localSourceAllow = [
      "bookmark"
      "hold"
      "send"
      "snapshot"
      "destroy"
      "mount"
    ];
    localTargetAllow = [
      "compression"
      "create"
      "mount"
      "mountpoint"
      "receive"
      "rollback"
      "destroy"
    ];
  };
}
