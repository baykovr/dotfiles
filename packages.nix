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
    daemonize
  ];
in with pkgs;
[
  binutils
  ack
  broot
  cargo
  gnumake
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
  ssm-session-manager-plugin
  terraform
  terraform-ls
  tldr
  tree
  virtualenv
  zip
  aws-sam-cli
  awscli2
  ssm-session-manager-plugin
  # 2024 
  eza
  victor-mono
  docker-compose
  poetry
  unzip
  nix-derivation
  comma
  act
  gh
  trivy
  tmux
 (python3.withPackages pypkgs)
]
