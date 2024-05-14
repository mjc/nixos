{...}: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "michael.joseph.cohen@gmail.com";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."325i.org" = {
      enableACME = true;
      root = "/var/www";
    };
    virtualHosts."ombi.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:5000";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."sonarr.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8989";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."prowlarr.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:9696";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."radarr.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:7878";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."bazarr.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:6767";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."sabnzbd.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."plex.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:32400";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."glances.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:61208";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."tautulli.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8181";
        proxyWebsockets = true;
      };
    };
    virtualHosts."overseerr.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:5055";
        proxyWebsockets = true;
      };
    };

    appendHttpConfig = ''
      real_ip_header CF-Connecting-IP;
    '';
  };
}
