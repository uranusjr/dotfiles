use path
use plat

# Use epm:install to populate these.
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-modules/dir

# Short-hand to set terminal title.
fn title {|t| print "\033]0;"$t"\007" }
fn title-pwd { title (path:base (tilde-abbr $pwd)) }

# ANSI escape sequence to reset terminal.
fn reset { print "\033c" }

set after-chdir = [
    {|dir| title-pwd }
    $@after-chdir
]

# Record pwd on startup as well.
title-pwd

# My usual prompt.
set edit:prompt = {
    use platform
    var hostname = (platform:hostname &strip-domain=$true)
    styled $plat:user'@'$hostname' ' green
    styled (path:base (tilde-abbr $pwd))' $ ' bright-blue
}
set edit:rprompt = { nop }

set E:FLIT_INSTALL_PYTHON = py
set E:PIP_NO_WARN_SCRIPT_LOCATION = true
set E:PIPENV_IGNORE_VIRTUALENVS = true
set E:PIPENV_VENV_IN_PROJECT = true

fn cd {|@a| dir:cd $@a }
fn pushd {|@a| dir:push $@a }
fn popd {|@a| dir:pop $@a }
fn pwd {|@a| echo $pwd }

fn ls {|@a| lsd --icon=never $@a }
fn cat {|@a| bat --plain --color=never $@a }

# Reset terminal title on SSH exit.
fn ssh {|@a|
    e:ssh $@a
    title-pwd
}

# Local settings.
eval (slurp < (path:join (path:dir (src)[name]) 'lib' 'site.elv'))

use readline-binding
