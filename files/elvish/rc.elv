use path
use plat

# Use epm:install to populate these.
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-modules/dir

# Short-hand to set terminal title.
fn title [@a]{ print "\033]0;"$@a"\007" }
title (path-base (tilde-abbr $pwd))

print "\e]7;file://"$pwd"\a"

after-chdir = [
    [dir]{  # Set title to pwd name.
        title (path-base (tilde-abbr $pwd))
    }
    [dir]{  # Emit OSC 7 for new tab to open here.
        print "\e]7;file://"(path:as-posix $pwd)"\a"
    }
    $@after-chdir
]

# My usual prompt.
edit:prompt = {
    use platform
    hostname = (platform:hostname &strip-domain=$true)
    styled $plat:user'@'$hostname' ' green
    styled (path-base (tilde-abbr $pwd))' $ ' bright-blue
}
edit:rprompt = { nop }

E:PIPENV_IGNORE_VIRTUALENVS = true

fn cd [@a]{ dir:cd $@a }
fn pushd [@a]{ dir:push $@a }
fn popd [@a]{ dir:pop $@a }
fn pwd [@a]{ echo $pwd }

fn ls [@a]{ lsd --icon=never $@a }
fn cat [@a]{ bat --plain --color=never $@a }

# Avoid Git status code exceptions.
fn git [@a]{ try { e:git $@a } except _ { nop } }

# Local settings.
-source (path:join (path-dir (src)[name]) 'lib' 'site.elv')

use readline-binding
