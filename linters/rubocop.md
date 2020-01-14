# Rubocop

https://github.com/rubocop-hq/rubocop

>RuboCop is a Ruby static code analyzer (a.k.a. linter) and code formatter. Out of the box it will enforce many of the guidelines outlined in the community Ruby Style Guide.

## Style/HashSyntax

Deciding to use the new syntax for hashes:

https://rubocop.readthedocs.io/en/latest/cops_style/#stylehashsyntax


## Different ways to disable cops

[RuboCop your Ruby: enable, disable and configure your linter checks](https://medium.freecodecamp.org/rubocop-enable-disable-and-configure-linter-checks-for-your-ruby-code-475fbf11046a#3f8e)

https://rubocop.readthedocs.io/en/latest/configuration/#configuration

## - with Atom

Merge master of app into branch, master had `.ruby_version` file with `2.3`.
Rubocop was having a mare!

```bash

# install rbenv version for 2.3.0
rbenv install 2.3.0

#install bundler for new ruby version
gem install bundler
```

run bundle install for project - which has rubocop gem

this was useful http://stackoverflow.com/questions/21275951/rbenv-ruby-command-not-found
