# Use epm:install to populate these.
use github.com/zzamboni/elvish-modules/dir

# Short-hand to set terminal title.
fn title [@a]{ print "\033]0;"$@a"\007" }
path-base (tilde-abbr $pwd) | title

# Set the terminal title on working directory change.
after-chdir = [
    [dir]{ tilde-abbr $pwd | title }
    $@after-chdir
]

# My usual prompt.
edit:prompt = {
    use platform
    hostname = (platform:hostname &strip-domain=$true)
    styled $E:USER'@'$hostname' ' green
    styled (path-base (tilde-abbr $pwd))' $ ' bright-blue
}
edit:rprompt = { nop }

fn cd [@a]{ dir:cd $@a }
fn pushd [@a]{ dir:push $@a }
fn popd [@a]{ dir:pop $@a }

fn ls [@a]{ lsd --icon=never $@a }
fn cat [@a]{ bat --plain --color=never $@a }

# Local settings.
use site

paths = [
    $@site:_paths
    $@paths
]

use readline-binding
