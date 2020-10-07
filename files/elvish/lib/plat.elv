# Platform-specific stuff not provided by builtin.

use platform

# Username.
get-user = {
    if $platform:is-windows {
        echo $E:USERNAME
    } else {
        echo $E:USER
    }
}
user = ($get-user)
username = $user

# The home directory.
get-home = {
    if $platform:is-windows {
        echo $E:USERPROFILE
    } else {
        echo $E:HOME
    }
}
home = ($get-home)
