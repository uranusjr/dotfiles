use github.com/zzamboni/elvish-modules/nix

E:LANG = 'en_US.UTF-8'
E:LC_ALL = 'en_US.UTF-8'

nix:single-user-setup

edit:rprompt = {
    styled-segment '  WSL  ' &fg-color=black &bg-color=white
}

# Report current directory to Windows Terminal.
# https://github.com/microsoft/terminal/issues/3158#issuecomment-764003033
fn osc99 [p]{
    # Windows Terminal requires Windows path, so we use wsl.exe to convert.
    print "\033"']9;9;"'(wsl $p)'"'"\007"
}

after-chdir = [
    [dir]{ osc99 $pwd }
    $@after-chdir
]

# Record pwd on startup as well.
osc99 $pwd

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
