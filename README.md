# My Dot Files

My dot files to use on CLI environments on macOS, Windows, and Ubuntu in WSL, using:

* Nix on macOS and Ubuntu, [Scoop](https://scoop.sh/) on Windows
* Elvish (custom Scoop bucket on Windows)
* VIM with [vim-plug](https://github.com/junegunn/vim-plug)
* Cargo via rustup
* `diff-so-fancy`, ignore on Windows
* `scoop install uutils` on Windows
* Python 3 (to run the `linkthem` helper)

On Windows, [developer mode](https://docs.microsoft.com/en-us/windows/uwp/get-started/enable-your-device-for-development) can be enabled for symlinks.

## Usage

A simple Python script "linkthem" can be sed to link files into the home directory. Run

    ./linkthem --help

for details.

## Site-specific configurations

* Create a file `~/.elvish/sites/_.txt` that contains the name to load, e.g. `tp-mba`.
* Link one of the site-specific gitconfig files to `.gitconfig_site/_.properties`.

## Copying

Don't really want to bother putting up a license for this. Please ask me first before re-using anything.
