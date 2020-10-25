use path
use plat

# Use epm:install to populate these.
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-modules/dir

# Short-hand to set terminal title.
fn title [t]{ print "\033]0;"$t"\007" }
fn title-pwd []{ title (path-base (tilde-abbr $pwd)) }

fn osc7 [p]{ print "\e]7;file://"(path:as-posix $p)"\a" }

after-chdir = [
    [dir]{ osc7 $pwd }
    [dir]{ title-pwd }
    $@after-chdir
]

# Record pwd on startup as well.
title-pwd
osc7 $pwd

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

# Reset terminal title on SSH exit.
fn ssh [@a]{
    e:ssh $@a
    title-pwd
}

# Avoid Git status code exceptions.
fn git [@a]{ try { e:git $@a } except _ { nop } }

# Local settings.
-source (path:join (path-dir (src)[name]) 'lib' 'site.elv')

use readline-binding
