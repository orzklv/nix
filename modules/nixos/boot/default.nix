# Keep all declarative bootloader configurations here
{
  # List all bootloaders here
  grub = import ./grub.nix;
  systemd = import ./systemd.nix;
}
