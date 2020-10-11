# Path operations not provided by builtin.

use platform
use str

# Directory separator.
sep = '/'
if $platform:is-windows {
    sep = '\'
}

# Join a list of component into a path.
fn join [@parts]{
    str:join $sep $parts
}

# Replace last path component of $orig with $name.
fn with-name [orig name]{
    join (path-dir $orig) $name
}

# On Windows, replace '\' with '/'; no-nop on UNIX.
fn as-posix [orig]{
    if $platform:is-windows {
        str:replace '\' '/' $orig
    } else {
        put $orig
    }
}
