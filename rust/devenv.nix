{ pkgs, ... }:

{
  packages = [
    pkgs.jujutsu
    pkgs.lazygit
    pkgs.git

    # pkgs.wasm-pack
    # pkgs.binaryen # use a newer version of wasm-opt
    # pkgs.nodejs
  ];


  languages.rust = {
    enable = true;
    # https://devenv.sh/reference/options/#languagesrustchannel
    channel = "nightly";

    components = [ "rustc" "cargo" "clippy" "rustfmt" "rust-analyzer" "rust-std" ];
    # targets = [ "wasm32-unknown-unknown" ];
  };

  git-hooks.hooks = {
    clippy = {
      enable = true;
      settings.offline = false;
      extraPackages = [ pkgs.openssl ];
    };
    rustfmt.enable = true;
  };
  git-hooks.settings.rust.cargoManifestPath = "./Cargo.toml";

  # enterShell = ''
  # '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # See full reference at https://devenv.sh/reference/options/
}
