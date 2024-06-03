{...}: {
  virtualisation.oci-containers.containers.fileflows-server = {
    image = "revenz/fileflows";
    autoStart = true;
    ports = ["19200:5000"];
    environment = {
      TZ = "America/Denver";
    };
    volumes = [
      "/tmp/fileflows:/tmp"
      "/var/lib/fileflows/data:/data"
      "/var/lib/fileflows/logs:/app/Logs"
      "/mnt/tv:/mnt/tv"
      "/mnt/movies:/mnt/movies"
    ];
  };

  virtualisation.oci-containers.containers.fileflows-node = {
    image = "revenz/fileflows";
    autoStart = true;
    ports = ["19201:5000"];
    environment = {
      ServerUrl = "http://fileflows-server:192000";
      FFNODE = "1";
      NodeName = "tina-node";
      TZ = "America/Denver";
    };
    volumes = [
      "/tmp/fileflows:/tmp"
      "/var/lib/fileflows/data:/data"
      "/var/lib/fileflows/logs:/app/Logs"
      "/mnt/tv:/mnt/tv"
      "/mnt/movies:/mnt/movies"
    ];
  };
}
