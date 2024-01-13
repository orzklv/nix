{config, ...}: {
  home-manager.users = {
    # Media folder to symlink /media
    sakhib.file."Media" = {
      source = config.lib.file.mkOutOfStoreSymlink "/media";
    };
  };
}
