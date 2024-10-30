{ pkgs
, inputs
, ...
}: {
  config = {
    # Installing zsh for system
    programs.zsh.enable = true;

    # All users default shell must be zsh
    users.defaultUserShell = pkgs.zsh;

    # System configurations
    environment = {
      shells = with pkgs; [ zsh ];
      pathsToLink = [ "/share/zsh" ];
      systemPackages = [
        inputs.home-manager.packages.${pkgs.system}.default
      ];
    };
  };
}
