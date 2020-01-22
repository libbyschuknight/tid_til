# Setting up your Development Environment - Ruby / Rails

[Setup Ruby On Rails on macOS 10.12 XXX - A guide to setting up a Ruby on Rails development environment](https://gorails.com/setup/osx/)

Has older macOS's.

## What I do / programs I use

Check updates for your Mac. Run the updates for anything to do with the OS and xcode

Download Xcode - xcode app - from app store - do I need this or can I just get xcode command line tool?

install:

chrome

slack

iterm2

brew

xcode command line - should be installed from xcode app

zsh - or use bash, up to you

on-my-zsh - if using zsh

ruby build & rbenv - <https://github.com/sstephenson/rbenv#homebrew-on-mac-os-x>

NOTE: do not install node via Homebrew

<https://stackoverflow.com/questions/28017374/what-is-the-suggested-way-to-install-brew-node-js-io-js-nvm-npm-on-os-x/50266406#50266406>

Use `nvm` or `yarn`

node

text editor - you choose, other devs using atom, vim, sublime, vscode
(I am currently using vscode)

postgres - install with brew and follow instructions

gems

bundler

rails

then run command `rbenv rehash`

## Ruby and Rails

[Install Rails: A step-by-step guide](http://installrails.com/)

### Upgrading `rbenv` version

At work we have anti virus software that makes installs extremely slow. It took 30 mintues for this command to run for me `rbenv install 2.6.3`

> Info from colleague re upgrading:
>
> upgrading all of our environments to ruby 2.6.3. This includes your local development environment. I will send out a >reminder when the MR with the version change is headed to master.
> `rbenv install 2.6.3`
>
> Below are some tips and reminders to help make bundle install easier and faster.
> MAKE BUNDLE INSTALL FASTER:
> That first bundle install takes forever. You have to build nokogiri and all the other native extensions. One way to >speed that up is to configure Bundler to run in parallel. Bundler provides a jobs config to do just that. The value >specifies the number of gems Bundler can install in parallel, defaulting to 1. I would suggest setting that value to >the number of cores you have on you machine, but it’s up to you. You can specify the number of jobs as a part of the >global Bundler config via bundle config jobs 4. Alternatively, you can specify the number of jobs as a part of the >bundle command (bundle install --jobs=4). See <https://bundler.io/v1.17/man/bundle-config.1.html> for more information.
>
> COMMON ERRORS:
> The mysql2 gem fails to install
> See the “If you cannot build mysql2 gem on OS X Mojave” section on <https://confluence.fluxfederation.com/pages/>viewpage.action?pageId=463372499> (or <https://gist.github.com/fernandoaleman/ee3ac6957c2ba4f7d7d33a251d58b191> for more >history)
>
> The error 'parse_pc': .pc for libffi doesn't exist
> bundle install fails with an error like:
> .../.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/pkg-config-1.2.8/lib/pkg-config.rb:299:in `parse_pc': .pc for >libffi doesn't exist. (RuntimeError)
> You need to provide PKG_CONFIG_PATH like this (the actual location may vary):
> PKG_CONFIG_PATH=/usr/local/opt/libffi/lib/pkgconfig bundle install


---

[How to Show Hidden Files on MacOS with a Keyboard Shortcut](http://osxdaily.com/2018/02/12/show-hidden-files-mac-keyboard-shortcut/)

[New Tab iTerm2 within Current Directory](https://medium.com/ayuth/new-tab-iterm2-with-in-current-directory-627b0c31734a)


---

Other programs??
- add image
- spectacle
- time out
- others...

## Themes for vscode, iterm

### <https://github.com/wesbos/cobalt2-vscode>

### <https://github.com/wesbos/Cobalt2-iterm>

- `pip` installtion, should be using `python3`,  and therefore it will already be installed but have to refer to it as `pip3`

> UPDATE: This is no longer necessary with Python3.4. It installs pip3 as part of the stock install.

<https://stackoverflow.com/questions/20082935/how-to-install-pip-for-python-3-on-mac-os-x>

So just needed to do `pip3 install --user powerline-status` as per the instructions.
