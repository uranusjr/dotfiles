use github.com/zzamboni/elvish-modules/nix

nix:single-user-setup

paths = [
    $E:HOME/.local/bin
    $E:HOME/.cargo/bin
    $@paths
]
