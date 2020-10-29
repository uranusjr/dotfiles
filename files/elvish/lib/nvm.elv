# Providing nvm functionalities in Elvish, since the official nvm functions
# only work in POSIX-compliant shells. This is for POSIX system only! Windows
# users should use [nvm-windows], which works with Elvish out of the box.
# [nvm-windows]: https://github.com/coreybutler/nvm-windows

use str

nvm-prefix = (path-clean $E:HOME)'/.nvm'
if (has-env NVM_DIR) {
    nvm-prefix = (path-clean $E:NVM_DIR)
}

node-versions-dir = $nvm-prefix'/versions/node'

# Launch a subshell to initialize and run the real nvm.
# A stopgap to access most nvm functionalities.
fn in-subshell [@a]{
    sh --noprofile -c '. '$nvm-prefix'/nvm.sh; $@' 'nvm.sh' $@a
}

# For stuffs not exposed in the top-level...
fn nvm [@a]{
    in-subshell 'nvm' $@a
}

fn paths-without-node-version [old-paths new-paths]{
    for p $old-paths {
        if (!= 0 (str:index $p $node-versions-dir)) {
            new-paths = [$@new-paths $p]
        }
    }
    put $new-paths
}

fn use [short-name]{
    real-name = (in-subshell 'nvm_match_version' $short-name)
    new-paths = [$node-versions-dir'/'$real-name'/bin']
    paths = (paths-without-node-version $paths $new-paths)
    echo 'activated:' $real-name
}

fn deactivate []{
    paths = (paths-without-node-version $paths [])
    echo 'deactivated all node versions'
}

fn current []{
    node-exe = ''
    try {
        node-exe = (which node)
    } except _ {
        echo 'error: node executable not found' >&2
        return
    }
    if (== 0 (str:index $node-exe $node-versions-dir)) {
        sub-path = (str:trim-prefix $node-exe $node-versions-dir)
        echo [(str:split '/' $sub-path)][1]
    } else {
        echo 'system'
    }
}

fn install [@a]{
    in-subshell 'nvm' 'install' $@a
}

fn version []{
    pwd=$nvm-prefix git describe  # Good enough.
}

# Initialize default version on import.
try {
    fclose (fopen $nvm-prefix'/nvm.sh')
} except {
    echo 'warning: nvm expected in '$nvm-prefix', but not found' >&2
} else {
    $use~ 'default'
}
