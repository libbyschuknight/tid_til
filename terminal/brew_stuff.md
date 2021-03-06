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

## What I have installed at work - Jan 2020

After setting up new computer, with a company install script

```bash
autoconf		icu4c			little-cms2		redis
automake		imagemagick@6		ncurses			ruby
aws-elasticbeanstalk	jpeg			node			ruby-install
awscli			jpegoptim		oniguruma		scour
bison			jq			openjpeg		sqlite
chruby			kompose			openssl@1.1		terraform
coreutils		libffi			pcre			terraform_landscape
direnv			libidn2			pcre2			webp
freetype		libpng			pkg-config		wget
fzf			libtiff			pngcrush		xz
gdbm			libtool			postgresql@10		yarn
gettext			libunistring		python			zsh
git			libxml2			python@3.8
hub			libyaml			readline
```

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

## brew cask

<https://formulae.brew.sh/cask/>

>This is a listing of all casks available via the Homebrew package manager for macOS.

<https://github.com/Homebrew/homebrew-cask>

<https://github.com/Homebrew/homebrew-cask/blob/master/USAGE.md>

>Homebrew Cask extends Homebrew and brings its elegance, simplicity, and speed to the installation and management of GUI macOS applications such as Atom and Google Chrome.

e.g.

```bash
brew cask install <program>
```

### chromedriver

```bash
brew cask install chromedriver
```

Was getting this error when trying to run a feature spec

```bash
Failures:

  1) ChildRoutines loads
     Failure/Error: visit routines_child_path(child.families_id)

     Selenium::WebDriver::Error::SessionNotCreatedError:
       session not created: This version of ChromeDriver only supports Chrome version 80
         (Driver info: chromedriver=80.0.3987.106 (f68069574609230cf9b635cd784cfb1bf81bb53a-refs/branch-heads/3987@{#882}),platform=Mac OS X 10.15.4 x86_64)
```


OLD
Ran `brew cask install chromedriver`, said was installed and suggested re-installing:

```bash
>brew cask reinstall chromedriver

==> Downloading https://chromedriver.storage.googleapis.com/84.0.4147.30/chromedriver_mac64.zip
######################################################################## 100.0%
==> Verifying SHA-256 checksum for Cask 'chromedriver'.
==> Uninstalling Cask chromedriver
==> Unlinking Binary '/usr/local/bin/chromedriver'.
==> Purging files for version 80.0.3987.106 of Cask chromedriver
==> Installing Cask chromedriver
==> Linking Binary 'chromedriver' to '/usr/local/bin/chromedriver'.
🍺  chromedriver was successfully installed!
```

**27 Jan 2021**

Similar error

```bash
 2) Registration with sign up forms creates a new centre on educator signup
     Failure/Error: visit "/signup?educator_signup=true"

     Selenium::WebDriver::Error::SessionNotCreatedError:
       session not created: This version of ChromeDriver only supports Chrome version 86
       Current browser version is 88.0.4324.96 with binary path /Applications/Google Chrome.app/Contents/MacOS/Google Chrome
         (Driver info: chromedriver=86.0.4240.22 (398b0743353ff36fb1b82468f63a3a93b4e2e89e-refs/branch-heads/4240@{#378}),platform=Mac OS X 11.0.0 x86_64)
```

Tried the above and `brew cask reinstall chromedriver` is an outdated way of doing it.

```bash
brew install --cask chromedriver

Error:
  homebrew-core is a shallow clone.
  homebrew-cask is a shallow clone.
To `brew update`, first run:
  git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core fetch --unshallow
  git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask fetch --unshallow
This restriction has been made on GitHub's request because updating shallow
clones is an extremely expensive operation due to the tree layout and traffic of
Homebrew/homebrew-core and Homebrew/homebrew-cask. We don't do this for you
automatically to avoid repeatedly performing an expensive unshallow operation in
CI systems (which should instead be fixed to not use shallow clones). Sorry for
the inconvenience!
Warning: Cask 'chromedriver' is already installed.

To re-install chromedriver, run:
  brew reinstall chromedriver
```

Run `brew reinstall chromedriver` next time
