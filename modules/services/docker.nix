{...}: {
  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
    # TODO: figure out nvidia containers
  };

  virtualisation.oci-containers.backend = "docker";
  
}
