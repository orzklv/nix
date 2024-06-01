{
  config,
  lib,
  pkgs,
  ...
}: {
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
      backend = "docker";
    };
  };
}
