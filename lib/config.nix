{lib}: let
  mapSystem = {
    list,
    inputs,
    outputs,
    opath ? ../.,
  }: let
    # Generate absolute path to the configuration
    path = name:
      opath + "/hosts/${lib.toLower name}/configuration.nix";

    #   Name  =                Value
    # "Lorem" = orzklv.lib.config.makeSystem "station";
    system = name: {
      inherit name;
      value = makeSystem {
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

  makeSystem = {
    path,
    inputs,
    outputs,
  }: let
    attr = {
      modules = [
        # > Our main nixos configuration file <
        path
      ];
      specialArgs = {inherit inputs outputs;};
    };
  in
    lib.nixosSystem attr;
in {
  inherit mapSystem makeSystem;
}
