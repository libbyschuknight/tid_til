# Gem Stuff

### Using local gem (on your computer)

```ruby
gem "bananas", "~> 1.1.0" path: "../bananas"
```

### Setting the version

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
http://railsapps.github.io/managing-rails-versions-gems.html

They do different things:
- http://guides.rubygems.org/patterns/#pessimistic-version-constraint
- https://robots.thoughtbot.com/rubys-pessimistic-operator


### Change back to older version of local gem

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

`bundle open <gem>`
http://bundler.io/v1.10/bundle_open.html
>Opens the source directory of the given bundled gem

`bundle pristine <gem>`
https://bundler.io/v1.15/man/bundle-pristine.1.html
>Restores installed gems to their pristine condition


## To see what versions of gems have
e.g. to see what different versions of rails you have logically

```
gem list
...
rails (5.0.1, 5.0.0.1, 4.2.7.1, 4.2.6, 4.2.5.1, 4.2.5, 4.2.3, 4.2.1, 4.2.0, 3.2.15)
rails-deprecated_sanitizer (1.0.3)
rails-dom-testing (2.0.2, 2.0.1, 1.0.8, 1.0.7, 1.0.6)
...
```
