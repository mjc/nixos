{
  config,
  pkgs,
  ...
}: {
  # doesn't work yet
  services.livebook = {
    enableUserService = true;
    environment = {
      LIVEBOOK_PORT = 20123;
      LIVEBOOK_PASSWORD = "CheeW9ha";
    };
    environmentFile = "/var/lib/livebook/livebook.env";
    extraPackages = with pkgs; [gcc gnumake];
  };

  services.nginx.virtualHosts."livebook.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.livebook.environment.LIVEBOOK_PORT}";
    };
  };
}
