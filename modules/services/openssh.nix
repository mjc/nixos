{...}: {
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.endlessh-go = {
    enable = true;
    extraOptions = [
      "--logtostderr"
      "-v=1"
    ];
  };
}
