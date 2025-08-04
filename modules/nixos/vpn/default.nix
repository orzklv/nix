{config, ...}: {
  config = {
    sops.secrets = {
      hk-ns1 = {
        format = "binary";
        sopsFile = ../../../secrets/hk-ns1.hell;
      };
      gk-ns1 = {
        format = "binary";
        sopsFile = ../../../secrets/gk-ns1.hell;
      };
      gk-ns2 = {
        format = "binary";
        sopsFile = ../../../secrets/gk-ns2.hell;
      };
    };

    services.openvpn.servers = {
      hk-ns1 = {
        autoStart = false;
        updateResolvConf = true;
        config = ''config ${config.sops.secrets.hk-ns1.path}'';
      };
      gk-ns1 = {
        autoStart = false;
        updateResolvConf = true;
        config = ''config ${config.sops.secrets.gk-ns1.path}'';
      };
      gk-ns2 = {
        autoStart = false;
        updateResolvConf = true;
        config = ''config ${config.sops.secrets.gk-ns2.path}'';
      };
    };
  };
}
