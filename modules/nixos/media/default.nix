{
  config,
  lib,
  ...
}: {
  config.system.activationScripts.createMediaSymlink = lib.stringAfter ["users"] ''
    # if [ "${toString config.users.users.sakhib.isNormalUser}" = "true" ] && [ -d /media ]; then
    #   ln -sfn /media ${config.users.users.sakhib.home}/Media
    # fi

    # loop /home every user folder and create symlink to /media folder as Media, e.g: /home/sakhib/Media
    for user in /home/*; do
      if [ -d /media ]; then
        ln -sfn /media $user/Media
        chown -R :users $user/Media
        chmod -R 777 $user/Media
      fi  
    done
  '';
}