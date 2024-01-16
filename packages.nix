{ pkgs }:
let
  pypkgs = ps: with ps; [
    boto3
  ];
in with pkgs;
[
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
  # 
  eza
  victor-mono
  rofi
  docker-compose
 (python3.withPackages pypkgs)
]
