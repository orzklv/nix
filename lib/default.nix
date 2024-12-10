{lib}: rec {
  config = import ./config.nix {inherit lib;};
}
