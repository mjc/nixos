{...}: {
  virtualisation.oci-containers.containers.jdownloader2 = {
    image = "jlesage/jdownloader-2";
    ports = ["5800:5800"];
    environment = {
      USER_ID = "1000";
      GROUP_ID = "994";
      UMASK = "017";
    };
    volumes = ["/var/lib/jdownloader2:/config:rw" "/mnt/downloads:/output:rw"];
    autoStart = true;
  };
}
