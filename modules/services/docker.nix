{...}: {
  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
    # TODO: figure out nvidia containers
  };
}
