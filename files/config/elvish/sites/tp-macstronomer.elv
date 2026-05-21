use str

# use github.com/tesujimath/direlv/direlv
use github.com/xiaq/elvish-osc7/osc7

set E:LANG = 'en_US.UTF-8'
set E:LC_ALL = 'en_US.UTF-8'

set E:HOMEBREW_NO_INSTALL_CLEANUP = 'readline'

# eval (direlv:hook | slurp)
osc7:init-hook

set paths = [
    $E:HOME/.local/bin
    $E:HOME/.cargo/bin
    $E:HOME/.volta/bin
    $E:HOME/Library/PythonUp/bin
    $E:HOME/Library/PythonUp/cmd
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /opt/homebrew/opt/gnu-getopt/bin
    /opt/homebrew/opt/openjdk@21/bin
    /usr/local/bin
    $@paths
    /usr/sbin
    /sbin
]

fn pbcopy {|@a|
    print (str:trim-space (slurp)) | e:pbcopy
}

edit:add-var clip~ $pbcopy~
edit:add-var pbcopy~ $pbcopy~

edit:add-var dev~ {|@a|
    var prefix = $E:HOME'/Documents/programming/open-project'
    var python = $prefix'/.venv/bin/python'
    $python $prefix'/devit' $@a
}

edit:add-var start~ {|@a| open $@a }
