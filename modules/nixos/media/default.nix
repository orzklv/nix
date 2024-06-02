{
  config,
  lib,
  ...
}: {
  config = {
    system.activationScripts.createMediaSymlink = lib.stringAfter ["users"] ''
      # Loop /home every user folder and create symlink to /media folder as Media,
      # For example:
      #   - /home/sakhib/Media
      #   - /home/someone/Media
      if [ -d /media ]; then
        for user in /home/*; do
          if [ -d /media ]; then
            ln -sfn /media $user/Media
            chown -R :users $user/Media
            chmod -R 777 $user/Media
          fi
        done
      else
        echo "Media folder not found"
      fi
    '';
  };
}
