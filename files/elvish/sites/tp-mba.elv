use github.com/zzamboni/elvish-modules/nix

nix:single-user-setup

paths = [
    $E:HOME/Library/PythonUp/bin
    $E:HOME/Library/PythonUp/cmd
    $E:HOME/.local/bin
    $E:HOME/.cargo/bin
    /usr/local/bin
    /usr/sbin
    /sbin
    $@paths
]

fn dev [@a]{
    prefix = $E:HOME'/Documents/programming/open-project'
    evname = 'cpython-3.9-darwin-x86_64-92e397a3'
    python = $prefix'/.venvs/'$evname'/bin/python'
    $python $prefix'/devit' $@a
}

fn start [@a]{ open $@a }

fn pbcopy [@a]{
    use str
    print (str:trim-space (slurp)) | e:pbcopy
}

clip~ = $pbcopy~
