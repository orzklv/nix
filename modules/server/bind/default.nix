{
  # List your nameservers here
  master = import ./master.nix;
  slave = import ./slave.nix;
}
