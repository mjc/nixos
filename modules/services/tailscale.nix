{
  config,
  lib,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  # https://nixos.wiki/wiki/Tailscale#Known_issues
  networking.interfaces.tailscale0.useDHCP = lib.mkDefault false;
}
