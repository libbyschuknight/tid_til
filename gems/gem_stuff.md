# Gem Stuff

Using local gem (on your computer)

```ruby
gem "bananas", "~> 1.1.0" path: "../bananas"
```

Setting the version

```ruby
gem "rails", "2.3.10"
gem "apples", "~> 2.2"
```
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
