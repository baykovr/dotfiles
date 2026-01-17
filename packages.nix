{ pkgs, isDarwin ? false }:
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

  linuxOnly = with pkgs; [
    binutils
    bcc
    feh
    fuse
    fuse3
    grim
    redshift
    rofi
    scrot
    slock
    slurp
    xclip
  ];

  common = with pkgs; [
    ack
    act
    aws-sam-cli
    awscli2
    broot
    cargo
    claude-code
    comma
    docker-compose
    gcc-unwrapped
    gh
    gnumake
    jq
    k9s
    kubectl
    most
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nix-derivation
    nix-index
    nix-output-monitor
    nix-tree
    nixd
    nixdoc
    nixpkgs-fmt
    nodejs
    poetry
    ripgrep
    rustc
    ssm-session-manager-plugin
    terraform
    terraform-ls
    tldr
    tmux
    tree
    trivy
    unzip
    uv
    victor-mono
    virtualenv
    zip
    (python3.withPackages pypkgs)
  ];
in
  if isDarwin then common else common ++ linuxOnly
