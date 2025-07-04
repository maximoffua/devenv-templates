{ pkgs, ... }:

{
  packages = [ pkgs.git pkgs.gomod2nix pkgs.air pkgs.cobra-cli ];

  languages.go.enable = true;
  env.hardeningDisable = [ "fortify" ];

  git-hooks.hooks = {
    govet = {
      enable = true;
      pass_filenames = false;
    };
    gotest.enable = true;
    golangci-lint = {
      enable = true;
      pass_filenames = false;
    };
  };

  # enterShell = ''
  # '';

  outputs =
    let
      name = "my-app";
      version = "0.0.1";
    in
    { app = import ./default.nix { inherit pkgs name version; }; };

  # https://devenv.sh/tasks/
  tasks = {
    "gomod2nix:init".exec = "gomod2nix";
    "devenv:enterShell".after = [ "gomod2nix:init" ];
  };

  # See full reference at https://devenv.sh/reference/options/
}
