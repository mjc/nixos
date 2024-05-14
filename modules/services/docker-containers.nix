{...}: {
  virtualisation.oci-containers.containers = {
    jdownloader2 = {
      image = "jlesage/jdownloader-2";
      ports = ["5800:5800"];
      volumes = ["/var/lib/jdownloader2:/config:rw" "/mnt/downloads:/output:rw"];
      autoStart = true;
    };
    tautulli = {
      image = "linuxserver/tautulli";
      ports = ["8181:8181"];
      volumes = ["/var/lib/tautulli:/config:rw"];
      autoStart = true;
    };
  };
}
