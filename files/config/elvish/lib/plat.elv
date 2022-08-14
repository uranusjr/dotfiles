# Platform-specific stuff not provided by builtin.

use platform

# Username.
var user = ({
    if $platform:is-windows {
        echo $E:USERNAME
    } else {
        echo $E:USER
    }
})
var username = $user

# The home directory.
var home = ({
    if $platform:is-windows {
        echo $E:USERPROFILE
    } else {
        echo $E:HOME
    }
})
