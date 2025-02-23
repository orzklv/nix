{lib}: rec {
  config = import ./config.nix {inherit lib;};
  condition = import ./condition.nix {inherit lib;};
}
