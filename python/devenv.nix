{ pkgs, ... }:

{
  packages = [ pkgs.git ];

  languages.python = {
    enable = true;
    uv.enable = true;
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
