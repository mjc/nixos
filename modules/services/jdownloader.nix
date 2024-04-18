{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      jdownloader2 = {
        image = "jlesage/jdownloader-2";
        ports = ["5800:5800"];
        volumes = ["/var/lib/jdownloader2:/config:rw" "/mnt/downloads:/output:rw"];
        autoStart = true;
      };
    };
  };
}
