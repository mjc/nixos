{...}: {
  virtualisation.oci-containers.containers.jdownloader2 = {
    image = "jlesage/jdownloader-2";
    ports = ["5800:5800"];
    environment = {
      USER_ID = "1000";
      GROUP_ID = "994";
      UMASK = "002";
      TZ = "America/Denver";
      JDOWNLOADER_MAX_MEM = "2G";
    };
    volumes = ["/var/lib/jdownloader2:/config:rw" "/mnt/downloads/jdownloader:/output:rw"];
    autoStart = true;
  };
}
