edit:rprompt = {
    styled-segment ' Windows ' &fg-color=black &bg-color=white
}

scoop-apps = $E:LOCALAPPDATA'\Programs\Scoop\apps'

# Report current directory to Windows Terminal.
# https://github.com/microsoft/terminal/issues/3158#issuecomment-764003033
fn osc99 [p]{ print "\033"']9;9;"'$p'"'"\007" }

after-chdir = [
    [dir]{ osc99 $pwd }
    $@after-chdir
]

# Record pwd on startup as well.
osc99 $pwd

fn dev [@a]{
    prefix = $E:USERPROFILE'\Documents\programming\open-project'
    evname = 'cpython-3.8-windows-amd64-44da3294'
    python = $prefix'\.venvs\'$evname'\Scripts\python.exe'
    $python $prefix'\devit' $@a
}

fn open [p]{
    use str
    # explorer.exe returns 1 on seemingly successful operations, not sure what
    # that means. Let's just swallow it.
    try { explorer (str:replace '/' '\' $p) } except _ { nop }
}
start~ = $open~

fn clip [@a]{
    use str
    print (str:trim-space (slurp)) | e:clip
}
pbcopy~ = $clip~

E:PIPX_HOME = $E:LOCALAPPDATA'\Programs\pipx'
E:PIPX_BIN_DIR = $E:PIPX_HOME'\bin'

paths = [
    $E:PIPX_BIN_DIR
    $E:LOCALAPPDATA'\bin'
    $@paths
]
