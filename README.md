## Nix

Bootstrap within the working directory of `flake.nix`.
```
    nix run . -- build --flake .
```

Modify `home.nix`, reload via as follows.
```
    home-manager switch --flake .
```
