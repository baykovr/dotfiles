{ pkgs }:
let
  pypkgs = ps: with ps; [
    boto3
    toml
    rich
    requests
    pytest
    pynamodb
    beautifulsoup4
    fuse
    daemonize
  ];
in with pkgs;
[
  binutils
  # 2023
  ack
  broot
  cargo
  fuse
  gnumake
  grim
  jq
  k9s
  kubectl
  most
  nerdfonts
  nix-index
  nix-output-monitor
  nix-tree
  nixd
  nixdoc
  nixpkgs-fmt
  nodejs
  ripgrep
  rustc
  slurp
  ssm-session-manager-plugin
  terraform
  terraform-ls
  tldr
  tree
  virtualenv
  zip
  aws-sam-cli
  # 2024 
  eza
  victor-mono
  rofi
  docker-compose
  poetry
  xclip
  slock
  unzip
  nix-derivation
  comma
  feh
  redshift
  scrot
  bcc
  act
  gh
  trivy
  gcc-unwrapped
  fuse3
 (python3.withPackages pypkgs)
]