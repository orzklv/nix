{
  config,
  pkgs,
  ...
}: {
  config = {
    users.groups.admins = {
      name = "admins";
    };

    system.activationScripts.chownSrv = {
      text = ''
        #!/bin/sh
        chown -R :admins /srv
        chmod -R 777 /srv
      '';
    };

    systemd.services.chownSrv = {
      description = "Change ownership of /srv";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c ${config.system.activationScripts.chownSrv.text}";
        RemainAfterExit = true;
      };
    };
  };
}
