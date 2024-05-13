{}: {
  services.sanoid = {
    enable = true;
    datasets = [
      "wonderland/backup"
      "wonderland/home"
    ];
  };
  services.syncoid = {
    enable = true;
  };
}
