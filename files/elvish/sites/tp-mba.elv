paths = [
    $E:HOME/.local/bin
    $E:HOME/usr/local/bin
    $E:HOME/Library/PythonUp/bin
    $E:HOME/Library/PythonUp/cmd
    $E:HOME/.cargo/bin
    /usr/local/bin
    $@paths
]

fn start [@a]{ open $@a }
