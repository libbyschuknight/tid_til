# Brew

[Homebrew Documentation - FAQ](https://docs.brew.sh/FAQ)

Note: do not install node via Homebrew!!

<https://stackoverflow.com/questions/28017374/what-is-the-suggested-way-to-install-brew-node-js-io-js-nvm-npm-on-os-x/50266406#50266406>

```bash
brew update

brew list

brew outdated # find out what is out of date

brew upgrade # upgrade everything

brew upgrade <package>  # always consider doing one at a time

brew info <package>    # will show the info from when installed, can be useful for postgres start / stop commands

brew uninstall <package> # will uninstall / remove the package

# could do
brew update && brew upgrade # could possibly come up with issues with doing this

brew services list # lists out services that are running or not, good way to check what instances of mariadb were runnng
# Name         Status  User  Plist
# chromedriver stopped
# mariadb      started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.mariadb.plist
# mariadb@10.3 started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.mariadb@10.3.plist
# postgresql   started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
# verm         started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.verm.plist

```

## What I have installed at work (old)

`brew list`

```bash
Last login: Thu Sep 26 11:08:23 on ttys001
/own/habit_repos: brew list
autoconf        gdk-pixbuf        imagemagick   libtool			pkg-config		verm
boost			gettext			imagemagick@6		little-cms2		postgresql		webp
cairo			ghostscript		jpeg			mariadb			python			xz
chromedriver		git			kitchen-sync		mysql-client		python@2		yaml-cpp
cmake			glib			libcroco		node			rbenv			yarn
fontconfig		go			libffi			openjpeg		readline		zsh
freetype		gobject-introspection	libpng			openssl			ruby-build		zsh-completions
fribidi			graphite2		libpq			pango			sqlite
fzf			harfbuzz		librsvg			pcre			terminal-notifier
gdbm			icu4c			libtiff			pixman			tree
```

`the_silver_searcher` aka `ag` - <https://github.com/ggreer/the_silver_searcher>

### What I have installed at home (as of Nov 2019)

```bash
brew list
ack         gettext         libffi          mcrypt        pkg-config    watchman
autoconf	  git             libgpg-error    mhash         postgresql    webp
automake    go              libksba         minicom       python         wxmac
brew-cask   heroku          libpng          mysql         python3        xz
elixir      heroku-node     libtiff         node          rbenv          zsh
erlang      heroku-toolbelt libtool         openssl       readline
exercism    hunspell        libxml2         openssl@1.1   ruby-build
freetype    icu4c           libyaml         pcre          sqlite
fzf         imagemagick     little-cms2     php55         tree
gdbm        jpeg            mariadb         php55-mcrypt  unixodbc
```

## Installing fzf - fuzzy search

[fzf is a general-purpose command-line fuzzy finder.](https://github.com/junegunn/fzf#using-homebrew-or-linuxbrew)

> You can use Homebrew or Linuxbrew to install fzf.
>
> ```bash
> brew install fzf
>
> # To install useful key bindings and fuzzy completion:
> $(brew --prefix)/opt/fzf/install
> ```

Did `brew install fzf` but it didn't get the key bindings working. Wasn't sure what `(brew --prefix)/opt/fzf/install` does, tried, got error, searched and `brew -prefix` == `It means HOMEBREW_PREFIX which is /usr/local`.

```bash
$ brew --prefix
/usr/local
```

So then did this and got:

```bash
$ /usr/local/opt/fzf/install

Downloading bin/fzf ...
  - Already exists
  - Checking fzf executable ... 0.18.0
Do you want to enable fuzzy auto-completion? ([y]/n) y
Do you want to enable key bindings? ([y]/n) y

Generate /Users/SchuKnight/.fzf.bash ... OK
Generate /Users/SchuKnight/.fzf.zsh ... OK

Do you want to update your shell configuration files? ([y]/n) y

Update /Users/SchuKnight/.bashrc:
  - [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    + Added

Update /Users/SchuKnight/.zshrc:
  - [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    - Already exists: line #133

Finished. Restart your shell or reload config file.
   source ~/.bashrc  # bash
   source ~/.zshrc   # zsh

Use uninstall script to remove fzf.

For more information, see: https://github.com/junegunn/fzf
```

And now `crtl + r` gives me the fuzzy search

```bash
  11442  brew install fzf
  11443  brew list
  11444  (brew --prefix)/opt/fzf/install
  11445  brew --prefix
  11446  /usr/local/opt/fzf/install
  11447  loadzsh
  11448  brew list
> 11449  brew --prefix
  10000/10000 +S
>
```
