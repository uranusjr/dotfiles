use github.com/zzamboni/elvish-modules/nix

nix:single-user-setup

# Let's bind Nix SSL to pip to save us some trouble updating.
E:NIX_SSL_CERT_FILE = $E:HOME'/.local/pipx/shared/lib/python3.9/site-packages/pip/_vendor/certifi/cacert.pem'

paths = [
    $E:HOME/.local/bin
    $E:HOME/.cargo/bin
    /usr/local/bin
    $@paths
]

fn dev [@a]{
    prefix = $E:HOME'/Documents/programming/open-project'
    evname = 'cpython-3.9-darwin-x86_64-92e397a3'
    python = $prefix'/.venvs/'$evname'/bin/python'
    $python $prefix'/devit' $@a
}

fn start [@a]{ open $@a }

fn pbcopy [@a]{
    use str
    print (str:trim-space (slurp)) | e:pbcopy
}

clip~ = $pbcopy~
