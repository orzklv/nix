{ config
, lib
, ...
}: {
  config = {
    system.activationScripts.createMediaSymlink = lib.stringAfter [ "users" ] ''
      #
      # Loop /home every user folder and create symlink to /media folder as Media
      #
      if [ -d /media ]; then
        for user in /home/*; do
          if [ -d "$user" ]; then
            # Create symlink to /media folder as Media
            ln -sfn /media $user/Media

            # Change owner and permission of Media folder
            chown -R :users $user/Media 2>/dev/null

            # Change permission of Media folder
            chmod -R 777 $user/Media 2>/dev/null
          fi
        done
      else
        echo "Media folder not found"
      fi
    '';
  };
}
