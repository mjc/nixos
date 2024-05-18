{...}: let
  plexServerId = "80f3576ba8406589afabba3b900ad456ce191425";
in {
  virtualization.oci-containers.plex-sso = {
    enable = true;
    image = "drkno/plexsso:latest";
    restart = "unless-stopped";
    environment = {
      TZ = "America/Denver";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/var/lib/plex-sso:/config:rw"
    ];
    command = "-s ${plexServerId} -c .325i.org";
    user = "sso:sso";
    stop_grace_period = "120s";
    ports = [
      "4200:4200"
    ];
  };
}
