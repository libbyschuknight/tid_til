# Brew

[Homebrew Documentation - FAQ](https://docs.brew.sh/FAQ)

```bash
brew update

brew list

brew outdated # find out what is out of date

brew upgrade # upgrade everything

brew upgrade <package>  # always consider doing one at a time

brew info <package>    # will show the info from when installed, can be useful for postgres start / stop commands


# could do
brew update && brew upgrade # could possibly come up with issues with doing this
```

## What I have installed at work (old)

`brew list`

```bash
ack         git         pcre          rbenv               tree
autoconf    graphviz    phantomjs     readline            v8
exercism    htop        pkg-config    ruby-build          xz
fzf         libpng      postgresql    sqlite              yarn
gdbm        openssl     python        the_silver_searcher
```

`the_silver_searcher` aka `ag` - <https://github.com/ggreer/the_silver_searcher>

### What I have installed at home (as of Sept 2019)

```bash
ack         gdbm              jpeg          mariadb   php55-mcrypt  tree
autoconf    gettext           libgpg-error	mcrypt     pkg-config	  unixodbc
automake	  git               libksba       mhash     postgresql	  watchman
brew-cask	  heroku            libpng        minicom   python        webp
elixir      heroku-node	      libtiff       mysql     python3       wxmac
erlang      heroku-toolbelt	  libtool       node      rbenv         xz
exercism	  icu4c             libyaml       pcre      ruby-build
fzf         imagemagick	      little-cms2	  php55     sqlite
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

And now `crtl + r` gives me the fuzzy searc

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
