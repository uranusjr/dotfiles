# Path operations not provided by builtin.

use path
use platform
use str

# Replace last path component of $orig with $name.
fn with-name {|orig name|
    path:join (path:dir $orig) $name
}

# On Windows, replace '\' with '/'; no-nop on UNIX.
fn as-posix {|orig|
    if $platform:is-windows {
        str:replace '\' '/' $orig
    } else {
        put $orig
    }
}
