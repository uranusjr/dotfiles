# Providing nvm functionalities in Elvish, since the official nvm functions
# only work in POSIX-compliant shells. This is for POSIX system only! Windows
# users should use [nvm-windows], which works with Elvish out of the box.
# [nvm-windows]: https://github.com/coreybutler/nvm-windows

use str

prefix = (path-clean $E:HOME)'/.nvm'
if (has-env NVM_DIR) {
    prefix = (path-clean $E:NVM_DIR)
}

node-versions-dir = $prefix'/versions/node'

fn is-readable [p]{
    try {
        ls $p >/dev/null 2>&1
    } except {
        put $false
    } else {
        put $true
    }
}

# Launch a subshell to initialize and run the real nvm.
# A stopgap to access most nvm functionalities.
fn in-subshell [@a]{
    sh --noprofile -c '. '$prefix'/nvm.sh; $@' 'nvm.sh' $@a
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

# Use a version. Elvish does not support default values in positional
# arguments, so .nvmrc support is implemented in "init" instead.
fn use [env-name &reason=]{
    real-name = (in-subshell 'nvm_match_version' $env-name)
    new-paths = [$node-versions-dir'/'$real-name'/bin']
    paths = (paths-without-node-version $paths $new-paths)
    echo 'activated' $real-name $reason
}

fn deactivate []{
    paths = (paths-without-node-version $paths [])
    echo 'deactivated all node versions'
}

# Use version specified in .nvmrc or the default version. The .nvmrc logic is
# intentionally implemented differently from nvm. I personally dislike
# automatically traversing up the filesystem. You only need to init in the
# project root once before navigating anywhere else.
fn init []{
    env-name = 'default'
    reason = '<- default'
    rc-file = './.nvmrc'
    if (is-readable $rc-file) {
        env-name = (str:trim-space (slurp < $rc-file))
        reason = 'from .nvmrc'
    }
    $use~ &reason=$reason $env-name
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
    pwd=$prefix git describe  # Good enough.
}

# Initialize default version on import.
if (is-readable $prefix'/nvm.sh') {
    init
} else {
    echo 'warning: nvm expected in '$prefix', but not found' >&2
}
