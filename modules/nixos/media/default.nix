{
  config,
  lib,
  ...
}: {
  config = {
    system.activationScripts.createMediaSymlink = lib.stringAfter ["users"] ''
      # Function to create symlink and set permissions
      create_symlink_and_permissions() {
        local user_dir=$1

        if ln -sfn /media "$user_dir/Media"; then
          echo "Created symlink for $user_dir"
        else
          echo "Failed to create symlink for $user_dir" >&2
        fi

        if chown -R :users "$user_dir/Media" 2>/dev/null; then
          echo "Changed group ownership for $user_dir/Media"
        else
          echo "Failed to change group ownership for $user_dir/Media" >&2
        fi

        if chmod -R 777 "$user_dir/Media" 2>/dev/null; then
          echo "Changed permissions for $user_dir/Media"
        else
          echo "Failed to change permissions for $user_dir/Media" >&2
        fi
      }

      # Check if /media directory exists
      if [ -d /media ]; then
        # Loop through each user directory in /home
        for user in /home/*; do
          if [ -d "$user" ]; then
            create_symlink_and_permissions "$user"
          fi
        done
      else
        echo "Media folder not found"
      fi
    '';
  };
}
