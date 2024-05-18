{...}: {
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.endlessh.enable = true;

  security.pam.sshAgentAuth.enable = true;
}
