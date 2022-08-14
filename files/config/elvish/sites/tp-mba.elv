use github.com/zzamboni/elvish-modules/nix

E:LANG = 'en_US.UTF-8'
E:LC_ALL = 'en_US.UTF-8'

nix:single-user-setup

fn osc7 [p]{ print "\033]7;file://"$p"\007" }

after-chdir = [
    [dir]{ osc7 $pwd }
    $@after-chdir
]

# Record pwd on startup as well.
osc7 $pwd

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
    python = $prefix'/.venv/bin/python'
    $python $prefix'/devit' $@a
}

fn start [@a]{ open $@a }

fn pbcopy [@a]{
    use str
    print (str:trim-space (slurp)) | e:pbcopy
}

clip~ = $pbcopy~
