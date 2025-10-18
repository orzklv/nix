{lib}: let
  mapSystem = {
    list,
    inputs,
    outputs,
    opath ? ../.,
    type ? "nixos",
  }: let
    # Generate absolute path to the configuration
    path = name: let
      named =
        if type == "nixos"
        then (lib.toLower name)
        else name;
    in
      opath + "/hosts/${type}/${named}/configuration.nix";

    #   Name  =                Value
    # "Lorem" = orzklv.lib.config.makeSystem "station";
    system = name: {
      inherit name;
      value = makeSystem {
        inherit inputs outputs type;
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
    type ? "nixos",
  }: let
    attr = {
      modules = [
        # > Our main nixos configuration file <
        path
      ];
      specialArgs = {inherit inputs outputs;};
    };

    fn =
      if type == "darwin"
      then inputs.nix-darwin.lib.darwinSystem
      else lib.nixosSystem;
  in
    fn attr;
in {
  inherit mapSystem makeSystem;
}
