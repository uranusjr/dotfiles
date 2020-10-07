# Load site-specific rc from "~/.elvish/sites" named in "_.txt".

use str
use path

get-site-module = {
    txt = (path:join $path:home '.elvish' 'sites' '_.txt')
    name = (str:trim-space (slurp < $txt))
    path:with-name $txt $name'.elv'
}

-source ($get-site-module)
