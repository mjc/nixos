{config, ...}: {
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "zfs";
  # TODO: nvidia docker stuff
}
