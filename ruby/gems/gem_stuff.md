# Gem Stuff

<https://guides.rubygems.org>

[Ruby Gems, Gemfile & Bundler (The Ultimate Guide)](https://www.rubyguides.com/2018/09/ruby-gems-gemfiles-bundler/)

## [bundle exec](http://bundler.io/man/bundle-exec.1.html)

>This command executes the command, making all gems specified in the Gemfile(5) available to require in Ruby programs.

[What does bundle exec rake mean?](https://stackoverflow.com/questions/6588674/what-does-bundle-exec-rake-mean)

[Loading Additional Ruby Gems in Development](https://phili.pe/posts/loading-additional-ruby-gems-in-development/)

## Using local gem (on your computer)

```ruby
gem "bananas", "~> 1.1.0" path: "../bananas"
```

## Setting the version

Absolute Version Constraint

```ruby
gem "rails", "2.3.10"
```

Pessimistic Version Constraint

```ruby
gem "apples", "~> 2.2"
```

Optimistic Version Constraint

```ruby
gem "apples", ">=1.5.0"
```

<http://railsapps.github.io/managing-rails-versions-gems.html>

They do different things:

- <http://guides.rubygems.org/patterns/#pessimistic-version-constraint>
- <https://robots.thoughtbot.com/rubys-pessimistic-operator>

## Change back to older version of local gem

Using a gem, say `bubble_resources`, which is a representer gem, the master version was `5.0.0`.

App using this gem, say `bath_houses`, when I started code for new branch, was using version `4.4.0` of `bubble_resources`.

I had to add another representer to `bubble_resources`. Pointed `bath_houses` to local `bubble_resources v 5.0.0`.

Ran tests for `bath_houses`, these failed (didn't even run), as a table had been renamed in another branch of `bath_houses`, and `bubble_resources v 5.0.0` was using the new name, which was not in my local `bath_houses`.

*How to deal with this?*
Checkout a release and then make a branch off there (make sure you have stashed code you have already written).

```bash
git checkout 4.4.0
```

Instead of a branch name you will see the first few digits of the tags commit shard.
You will get something like this:

```bash
Note: checking out '4.4.0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at 3768438... Tag version 4.4.0
```

Make a new branch so any changes you make can be kept:

```bash
git branch -d feature/participant_roles_facade
```

Apply anything you have stashed - `git stash apply`

## [Bundler](https://bundler.io/)

`bundle _1.17.1_ install` this will run bundle for the version set e.g. `1.17.1`

[Run specific version of bundler](https://makandracards.com/makandra/9741-run-specific-version-of-bundler) - this site is old but...

<https://stackoverflow.com/questions/12092928/how-to-bundle-install-when-your-gemfile-requires-an-older-version-of-bundler>

[How to install and bundle your rails application with a specific bundler version](https://www.aloucaslabs.com/miniposts/how-to-install-and-bundle-your-rails-application-with-a-specific-bundler-version)

`bundle open <gem>`

<http://bundler.io/v1.10/bundle_open.html>

>Opens the source directory of the given bundled gem

`bundle pristine <gem>`

<https://bundler.io/v1.15/man/bundle-pristine.1.html>

>Restores installed gems to their pristine condition

## `require`

### `require: false

[What does 'require: false' in Gemfile mean?](https://stackoverflow.com/questions/4800721/what-does-require-false-in-gemfile-mean)

>You use :require => false when you want the gem to be installed but not "required".
>
>So in the example you gave: gem 'whenever', :require => false when someone runs bundle install the whenever gem would be installed as with gem install whenever. Whenever is used to create cron jobs by running a rake task but isn't usually used from within the rails (or other framework if not rails) application.
>
>So you can use :require => false for anything that you need to run from the command line but don't need within your code.

## To see what versions of gems have

e.g. to see what different versions of rails you have locally

```bash
gem list
...
rails (5.0.1, 5.0.0.1, 4.2.7.1, 4.2.6, 4.2.5.1, 4.2.5, 4.2.3, 4.2.1, 4.2.0, 3.2.15)
rails-deprecated_sanitizer (1.0.3)
rails-dom-testing (2.0.2, 2.0.1, 1.0.8, 1.0.7, 1.0.6)
...
```

## To install a particular version of a gem

<https://guides.rubygems.org/command-reference/#gem-install>

```bash
gem install rails --version=4.2.9`

# or

gem install bundler -v 1.17.3
```

## Check if gem installed

`gem list`

or

`gem list -i <gem-name>`

## Uninstall a gem

<https://guides.rubygems.org/rubygems-basics/#uninstalling-gems>

```bash
gem uninstall bundler
```

Uninstall a specific version

```bash
gem uninstall --default -v1.17.1 bundler
```

## Load paths

Question around what to use:

```ruby
require_relative './lib/admin_pattern_library/version'

# or

lib = File.expand_path("lib", __dir__)
```

<https://guides.rubygems.org/patterns/#declaring-dependencies,> section title `Requiring files relative to each other`

>Gems should not have to use __FILE__ to bring in other Ruby files in your gem.

## Rdoc

to stop building rdoc when you install gems or the bundle, you can add `gem: "--no-document"` to `~/.gemrc.` Then after reloading your term session, gem and bundle will stop building rdoc.

## GEMS

### [Rubocop](https://rubygems.org/gems/rubocop/versions/0.67.2)

See [linters/rubocop](../linters/rubocop.md)

### [Table Display](https://github.com/willbryant/table_display)

```bash
>> pt Customer.find(7139).purchases, :only => [:id, :purchase_price], :methods => [:start_date?]
+---------+----------------+-------------+
| id      | purchase_price | start_date? |
+---------+----------------+-------------+
| 2587972 |   '51.73'.to_d | false       |
| 2587973 |   '59.75'.to_d | false       |
| 2587974 |   '36.38'.to_d | false       |
| 2587975 |   '10.03'.to_d | false       |
| 2587976 |   '14.04'.to_d | false       |
| 2587977 |  '194.46'.to_d | false       |
| 2587978 |   '41.38'.to_d | false       |
| 2587979 |   '96.31'.to_d | false       |
...
```

```bash
>> pt User.all.limit(5), :only => [:id, :email, :first_name, :last_name]
+--------+--------------------------------+--------------+------------------+
| id     | email                          | first_name   | last_name        |
+--------+--------------------------------+--------------+------------------+
|   7999 | "user_7999@test@example.com"   | "Kate_7999"   | "Builder_7999"   |
| 120280 | "user_120280@test@example.com" | "Kate_120280" | "Builder_120280" |
| 138529 | "user_138529@test@example.com" | "Kate_138529" | "Builder_138529" |
| 163344 | "user_163344@test@example.com" | "Kate_163344" | "Builder_163344" |
| 167744 | "user_167744@test@example.com" | "Kate_167744" | "Builder_167744" |
+--------+---------------------------------+--------------+------------------+
```

### [ActiveModelSerializers](https://github.com/rails-api/active_model_serializers)

[JSON Serialization in Rails: A Complete Guide](https://buttercms.com/blog/json-serialization-in-rails-a-complete-guide)

[A Quickstart Guide to Using Serializer With Your Ruby on Rails API](https://itnext.io/a-quickstart-guide-to-using-serializer-with-your-ruby-on-rails-api-d5052dea52c5)
