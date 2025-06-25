{config, ...}: {
  config = {
    sops.secrets.ostl-configs = {
      format = "binary";
      sopsFile = ../../../../secrets/config-ostl.hell;
    };

    services.openvpn.servers = {
      kolyma = {
        autoStart = false;
        updateResolvConf = true;
        config = ''config ${config.sops.secrets.ostl-configs.path}'';
      };
    };
  };
}
