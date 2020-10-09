use github.com/zzamboni/elvish-modules/nix

nix:single-user-setup

edit:rprompt = {
    styled ' WSL ' black bg-white
}

paths = [
    $E:HOME/.local/bin
    $E:HOME/.cargo/bin
    $@paths
]
