{ pkgs }:
let
  pypkgs = ps: with ps; [
    boto3
    toml
    rich
    requests
    pytest
    asyncio
  ];
in with pkgs;
[
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
  # 01-2024 
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
 (python3.withPackages pypkgs)
]
