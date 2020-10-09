edit:rprompt = {
    styled ' Windows ' black bg-white
}

scoop-apps = 'C:\Users\uranusjr\AppData\Local\Programs\Scoop\apps'

fn dev [@a]{
    prefix = 'C:\Users\uranusjr\Documents\programming\open-project'
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

fn yarn [@a]{
    node $scoop-apps'\yarn\current\Yarn\bin\yarn.js' $@a
}

fn clip [@a]{
    use str
    print (str:trim-space (slurp)) | e:clip
}
pbcopy~ = $clip~
