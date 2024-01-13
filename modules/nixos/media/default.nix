{
  config,
  lib,
  ...
}: {
  config = {
    system.activationScripts.createMediaSymlink = lib.stringAfter ["users"] ''
      if [ "${toString config.users.users.sakhib.isNormalUser}" = "true" ]; then
        ln -sfn /media ${config.users.users.sakhib.home}/Media
      fi
    '';
  };
}
