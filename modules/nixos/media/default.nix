{config, lib, ...}: {
  config = {
    system.activationScripts.createMediaSymlink = lib.stringAfter [ "users" ] ''
    if [ "${config.users.users.sakhib.isNormalUser}" = "1" ]; then
      ln -sfn /media ${config.users.users.sakhib.home}/Media
    fi
    ''; 
  };
}
