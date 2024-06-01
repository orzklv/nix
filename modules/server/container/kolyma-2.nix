{
  config,
  lib,
  pkgs,
  ...
}: {
  
  # Enabling docker
  config.virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune = true;
    };
    oci-containers = {
      backend = "docker";
    };
  };

  config.virtualisation.oci-containers.containers = {
    git = {
      image = "gitlab/gitlab-ee:latest";
      hostname = "git.kolyma.uz";
      volumes = [
        "/srv/git/config:/etc/gitlab"
        "/srv/git/logs:/var/log/gitlab"
        "/srv/git/data:/var/opt/gitlab"
      ];
      ports = [
        "8450:80"
        "22:22"
      ];
      environmentFiles = ["/srv/git/.env"];
      extraOptions = [
        "--shm-size 256m"
      ];
    };
  };

  # Git Server SSH Port
  config.networking.firewall.allowedTCPPorts = [22];
  config.networking.firewall.allowedUDPPorts = [22];
}
