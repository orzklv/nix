{...}: {
  imports = [
    # Note:
    # Uncomment for the first time,
    # it keeps installing over and over.
    # ./mas.nix

    # Rest is fine
    ./taps.nix
    ./casks.nix
    ./formulae.nix
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
  };
}
