# Path operations not provided by builtin.

use platform
use str

# Directory separator.
sep = '/'
if $platform:is-windows {
    sep = '\'
}

# The home directory.
get-home = {
    if $platform:is-windows {
        echo $E:USERPROFILE
    } else {
        echo $E:HOME
    }
}
home = ($get-home)

# Join a list of component into a path.
fn join [@parts]{
    str:join $sep $parts
}

# Replace last path component of $orig with $name.
fn with-name [orig name]{
    join (path-dir $orig) $name
}
