# Load site-specific rc from "~/.elvish/sites" named in "_.txt".

use plat
use str

get-site-module = {
    txt = (path:join $plat:home '.elvish' 'sites' '_.txt')
    name = (str:trim-space (slurp < $txt))
    path:with-name $txt $name'.elv'
}

-source ($get-site-module)
