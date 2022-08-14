set E:LANG = 'en_US.UTF-8'
set E:LC_ALL = 'en_US.UTF-8'

fn osc7 {|p| print "\033]7;file://"$p"\007" }

set after-chdir = [
    {|dir| osc7 $pwd }
    $@after-chdir
]

# Record pwd on startup as well.
osc7 $pwd

set paths = [
    $E:HOME/.local/bin
    $E:HOME/Library/PythonUp/bin
    $E:HOME/Library/PythonUp/cmd
    /opt/homebrew/bin
    $@paths
]

fn dev {|@a|
    var prefix = $E:HOME'/Documents/programming/open-project'
    var python = $prefix'/.venv/bin/python'
    $python $prefix'/devit' $@a
}

fn start {|@a| open $@a }

fn pbcopy {|@a|
    use str
    print (str:trim-space (slurp)) | e:pbcopy
}

var clip~ = $pbcopy~
