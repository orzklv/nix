# Just a convenience function that returns the given Nixpkgs standard
# library extended with the Orzklv library.
nixpkgsLib: let
  mkOrzklvLib = import ./.;
in
  nixpkgsLib.extend (
    self: super: {
      orzklv = mkOrzklvLib {lib = self;};

      # For forward compatibility.
      literalExpression = super.literalExpression or super.literalExample;
      literalDocBook = super.literalDocBook or super.literalExample;
    }
  )
