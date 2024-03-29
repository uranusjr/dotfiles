use github.com/zzamboni/elvish-modules/nix

E:LANG=""

E:EDITOR = 'vim'

E:GOPATH = $E:HOME'/.local/share/go'

nix:single-user-setup

edit:rprompt = {
    styled-segment '  WSL  ' &fg-color=black &bg-color=white
}

# Report current directory to Windows Terminal.
# https://github.com/microsoft/terminal/issues/3158#issuecomment-764003033
fn osc99 [p]{
    print "\033"']9;9;"'$p'"'"\007"
}

after-chdir = [
    [dir]{ osc99 $pwd }
    $@after-chdir
]

# Record pwd on startup as well.
osc99 $pwd

fn dev [@a]{
    prefix = '/mnt/c/Users/uranusjr/Documents/programming/open-project'
    envname = 'cpython-3.7-linux-x86_64-18fb057a'
    python = $prefix'/.venvs/'$envname'/bin/python'
    $python $prefix'/devit' $@a
}

fn open [p]{
    # explorer.exe returns 1 on seemingly successful operations, not sure what
    # that means. Let's just swallow it.
    try { '/mnt/c/Windows/explorer.exe' (wslpath -w $p) } except _ { nop }
}
start~ = $open~

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
    $E:GOPATH/bin
    $@paths
]
