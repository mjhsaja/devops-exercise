let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = { allowUnfree = true; }; overlays = []; };

  kubectl = pkgs.kubectl.overrideAttrs (oldAttrs: rec {
    version = "1.28.4";
  });

  terraform = pkgs.terraform.overrideAttrs (oldAttrs: rec {
    version = "1.6.4";
  });

  google-cloud-sdk = pkgs.google-cloud-sdk.overrideAttrs (oldAttrs: rec {
    version = "452.0.1";
  });

  git = pkgs.git.overrideAttrs (oldAttrs: rec {
    version = "2.42.0";
  });

  podman = pkgs.podman.overrideAttrs (oldAttrs: rec {
    version = "4.7.2";
  });

  minikube = pkgs.minikube.overrideAttrs (oldAttrs: rec {
    version = "1.31.2";
  });

  go = pkgs.go.overrideAttrs (oldAttrs: rec {
    version = "1.21.5";
  });

in

pkgs.mkShell {
  packages = with pkgs; [
    kubectl
    terraform
    google-cloud-sdk
    git
    podman
    minikube
    nodejs_20
    pkgs.go
    python310
    python310Packages.pip
  ];

  shellHook = ''
    export NIX_SHELL_DIR=$PWD/.nix-shell
    export LC_ALL=C
    export LANG=C.utf8
    alias docker=podman
  '';
}