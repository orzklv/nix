# This file defines overlays
{inputs, ...}: {
  additions = import ./additions.nix {inherit inputs;};
  modifications = import ./modifications.nix {inherit inputs;};
  unstable = import ./unstable.nix {inherit inputs;};
}
