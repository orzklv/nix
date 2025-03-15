{
  config,
  inputs,
  ...
}: {
  imports = [inputs.demo-server.nixosModules.server];

  sops.secrets = {
    "xinux/demo-server" = {
      owner = config.services.tempserver.user;
    };
  };

  # Enable demo server module
  services.tempserver = {
    enable = true;
    port = 25888;
    database = {
      passwordFile = config.sops.secrets."xinux/demo-server".path;
    };
  };
}
