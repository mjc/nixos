{...}: {
  virtualisation.oci-containers.containers.nntp2nntp = {
    image = "lscr.io/linuxserver/nntp2nntp:latest";
    autoStart = true;
    ports = [
      "1563:1563"
    ];
    environment = {
      PUID = "1000";
      PGID = "1000";
      TZ = "America/Denver";
    };
    volumes = [
      "/var/lib/nntp2nntp:/config"
    ];
  };
}
