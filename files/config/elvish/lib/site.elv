# Load site-specific rc from "~/.elvish/sites" named in "_.txt".

use path
use pathx
use plat
use str

eval ({
    var txt = (path:join $plat:home '.config' 'elvish' 'sites' '_.txt')
    var name = (str:trim-space (slurp < $txt))
    slurp < (pathx:with-name $txt $name'.elv')
})
