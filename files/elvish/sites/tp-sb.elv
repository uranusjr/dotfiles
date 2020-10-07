scoop-apps = 'C:\Users\uranusjr\AppData\Local\Programs\Scoop\apps'

fn dev [@a]{
    prefix = 'C:\Users\uranusjr\Documents\programming\open-project'
    evname = 'cpython-3.8-windows-amd64-44da3294'
    python = $prefix'\.venvs\'$evname'\Scripts\python.exe'
    $python $prefix'\devit' $@a
}

fn open [@a]{ start $@a }

fn yarn [@a]{
    node $scoop-apps'\yarn\current\Yarn\bin\yarn.js' $@a
}
