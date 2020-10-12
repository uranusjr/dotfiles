use github.com/zzamboni/elvish-modules/nix

nix:single-user-setup

edit:rprompt = {
    styled '  WSL  ' black bg-white
}

fn clip [@a]{
    use str
    print (str:trim-space (slurp)) | e:clip.exe
}
pbcopy~ = $clip~

paths = [
    $E:HOME/.local/share/pythonup/bin
    $E:HOME/.local/share/pythonup/cmd
    $E:HOME/.local/bin
    $E:HOME/.cargo/bin
    $@paths
]
