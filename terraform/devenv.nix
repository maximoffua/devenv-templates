{ pkgs, config, inputs, ... }: let
  cfg = config.languages.terraform;
  terraform = if (cfg.version != null)
    then (inputs.nixpkgs-terraform.packages.${pkgs.stdenv.system}.${cfg.version} or (throw "Unsupported Terraform version, see https://github.com/stackbuilders/nixpkgs-terraform/blob/main/versions.json for the full list of supported versions."))
    else pkgs.terraform;
in {
  packages = [
    pkgs.jujutsu
    pkgs.lazygit
    pkgs.git

    pkgs.podman
    pkgs.docker-compose
    pkgs.docker-compose-language-service
    pkgs.podman-tui
  ];

  languages.terraform = {
    enable = true;
    # version = "1.8.4";
    package = terraform.withPlugins (tf: with tf; [
      docker
      keycloak
    ]);
  };

  git-hooks.hooks = {
    terraform-format.enable = true;
    tflint.enable = true;
  };

  # enterShell = ''
  # '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # See full reference at https://devenv.sh/reference/options/
}
