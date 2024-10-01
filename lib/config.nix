{ lib }:

{
  # WARNING!
  # Becomes impure when opath provided
  mapSystem =
    { list
    , inputs
    , outputs
    , opath ? ../.
    }:
    let
      # Generate absolute path to the configuration
      path = name: opath + "/nixos/${lib.toLower name}/configuration.nix";

      #   Name  =                Value
      # "Lorem" = self.lib.config.makeSystem "station";
      system = name: {
        name = name;
        value = lib.orzklv.config.makeSystem {
          inherit inputs outputs;
          path = path name;
        };
      };

      # [
      #   { name = "Lorem", value = config }
      #   { name = "Ipsum", value = config }
      # ]
      map = lib.map system list;
    in
    lib.listToAttrs map;

  makeSystem =
    { path
    , inputs
    , outputs
    }:
    lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs;
      };
      modules = [
        # > Our main nixos configuration file <
        path
      ];
    };
}
